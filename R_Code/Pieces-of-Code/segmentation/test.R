rm(list = ls())
source('segmentation.R')

s=load.wave('emotions/speech/neutral/f1neu1.wav')
T=length(s)/s$rate

bnds=segmentVoice(s)
bndi=bnds$idx
plot(s,type = 'l')
abline(v=bndi)

for(it in 2:length(bndi)) {
  save.wave(s[bndi[it-1]:bndi[it]],sprintf("seg%d.wav",it-1))
}
