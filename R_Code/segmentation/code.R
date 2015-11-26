rm(list = ls())

library(audio)
library(seewave)
source('iso226.R')
s=load.wave('emotions/speech/neutral/m2neu1.wav')

envelope=function(v) {
  vabs=abs(v)
  vfil=ffilter(vabs,from = 0.000001,to = 12,output='audioSample')
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
  
  # Find os-s and oe-s
  
  
  return(vdenv)
}

a=segmentVoice(s)
# plot(seq(1,length(a$v1env),length.out = length(s)),s,type = 'l')
plot(1:length(a),a,type = 'l')