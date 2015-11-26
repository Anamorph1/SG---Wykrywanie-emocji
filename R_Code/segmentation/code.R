el70=read.table('equalLoudnes70.txt',header=TRUE)
s=load.wave('emotions/speech/neutral/f1neu1.wav')

fftfilt=function(x,Fs,Fl,Fu,ker) {
  xfft=fft(x)
  wnlen=length(x)*(Fu-Fl)/Fs
  wnd=resamp(10^(ker/10),length(ker),wnlen)
  iFl=floor(Fl*(length(x)-1)/Fs + 1)
  mask=c(seq(0,0,length.out=iFl-1),wnd,seq(0,0,length.out=length(s)-2*length(wnd)-2*(iFl-1)),rev(wnd),seq(0,0,length.out=iFl-1))
  return(Re(fft(xfft*mask,inverse=TRUE))/length(x))
}

convhull=function(x) {
	imax=which.max(x)
	for(it in 2:imax) {
		if(x[it]<x[it-1]) {
			x[it]=x[it-1]
		}
	}
	for(it in (length(x)-1):(imax+1)) {
		if(x[it]<x[it+1]) {
			x[it]=x[it+1]
		}
	}
	return(x)
}

segmentRecursion=function(venv,th) {
  venvp=convhull(venv)-venv;
  imax=which.max(venvp)
  if(venvp[imax]/venv[imax] > th) {
    return(c(segmentRecursion(venv[1:imax],th),segmentRecursion(venv[(imax+1):length(venv)],th)+imax))
  } else {
    return(imax)
  }
}

segmentVoice=function(v) {
  vfil=resamp(v,g=16000,output='audioSample')
	vfil=ffilter(v,from=500,to=4000,wn='rectangle',output='audioSample')
	venv=ffilter(vfil^2,from=0.1,to=12,wn='hamming')
	dim(venv)=NULL
	return(segmentRecursion(venv,10^(2/10)))
}