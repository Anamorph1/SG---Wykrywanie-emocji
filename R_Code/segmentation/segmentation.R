library(audio)
library(seewave)
source('iso226.R')

score=function(x,idx,bn) {
  ix=x[idx]
  s=vector('double',length(idx))
  f1=ix <  bn[1]
  f2=ix >= bn[2]
  f3=!f1 & !f2
  s[f1]=0
  s[f2]=1
  s[f3]=(ix[f3]-bn[1])/(bn[2]-bn[1])
  return(s)
}

envelope=function(v) {
  vabs=abs(v)
  vfil=ffilter(vabs,from=0.000001,to=12,output='audioSample')
  vfil=ffilter(vfil,from=0.000001,to=12,output='audioSample')
  vres=resamp(vfil,g=100)
  dim(vres)=NULL
  min2=min(vres[vres > 0])
  vres[vres <= 0]=min2
  return(vres^0.3)
}

segmentVoice=function(v) {
  # Prepare to resample (low-pass 8kHz filter)
  vfil=ffilter(v,to=8000,output='audioSample')
  
  # Resample to 16kHz
  vres=resamp(vfil,g=16000,output='audioSample')
  
  # Equal loudness filter (iso226:2003)
  vequ=ffilter(vres,custom=10^((70-iso226(70,0,8000,512))/10),output='audioSample')
  
  # Split to channels
  vchan=list(ffilter(vequ,16000,150,1000,output='audioSample'),
             ffilter(vequ,16000,150,3000,output='audioSample'),
             ffilter(vequ,16000,from=150,output='audioSample'))
  
  # Compute normalized envelopes
  venv8=envelope(vchan[[3]])
  venvn=list(envelope(vchan[[1]])/venv8,envelope(vchan[[2]])/venv8)
  names(venvn)=c('envn1','envn3')
  
  # Compute onset envelope velocity
  vdenv=diff(venv8)
  vdenv[vdenv < 0] = 0
  vdenv[1] = 0
  vdenv[length(vdenv)] = 0
  
  # Find os-s, oe-s and op-s
  vddenv=diff(vdenv)
  vddenvs=c(vddenv,vddenv[length(vddenv)])
  vddenve=c(vddenv[1],vddenv)
  oss=which(vddenvs > 0 & vdenv == 0)
  oes=which(vddenve < 0 & vdenv == 0)
  ops=vector('double',length(oss))
  for(it in 1:length(oss)) {
    ops[it]=which.max(vdenv[oss[it]:oes[it]])+oss[it]-1
  }
  
  # Thresholds
  tb=c(0.01, 0.1)
  ts=c(0.6, 0.7)
  tc=c(0.85, 0.97)
  tvp=c(0.01, 0.1)
  
  # Scores
  bs=score(vdenv,ops,tb)
  ss=score(venvn$envn1,oes,ts)
  cs=score(venvn$envn1,oes,tc)
  vps=score(vdenv,ops,tvp)
  vs=ss*(1-cs)*vps
  
  # Filter candidates
  for(it in bs) {
  }
  
  out=list(floor(oss*length(v)/length(vdenv)),oss*length(v)/(length(vdenv)*v$rate))
  names(out)=c('idx','time')
  
  return(out)
}
