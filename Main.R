########################################## Preprocessing  #######################
rm(list = ls())
library(audio);
library(seewave);

source('Segmentation.R')
#loading a wave
s<-load.wave("f1neu1.wav");

#FFT
f<-spec(s);

#Low-Pass filter
w<-ffilter(s,to=4000,output = "audioSample");

#Sample rate change
finalfreq<-resamp(w,g=8000,output='audioSample');
finalfreqspec<-spec(finalfreq);

#noise removal
nonoise=rmnoise(finalfreq,output='audioSample');
nonoisespec<-spec(nonoise);
nonoisem=rmnoise(finalfreq,output='matrix');

#Differentiate
preemfaza<-0;
for(i in 2:18389){
  preemfaza[i]<-nonoisem[i]-nonoisem[i-1];
}
preemfazaaudio<-audioSample(preemfaza,rate=8000);
preemfazaspec<-spec(preemfazaaudio);
########################################## Segmentation  #######################
s2=preemfazaaudio;
T=length(s2)/s2$rate

bnds=segmentVoice(s2)
bndi=bnds$idx
plot(s2,type = 'l')
abline(v=bndi)

for(it in 2:length(bndi)) {
  save.wave(s2[bndi[it-1]:bndi[it]],sprintf("seg%d.wav",it-1))}
end

###################################        Ekstrakcja cech           ###################################






###################################       SVM          ###################################
