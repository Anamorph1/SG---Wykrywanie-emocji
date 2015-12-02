library(audio);
library(seewave);
library(tuneR)
source('Segmentation.R')

compute_params <- function(filename) {

  
#loading a wave
s<-load.wave(filename);

#FFT
#f<-spec(s); # to chyba tylko wyswietla

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
#plot(s2,type = 'l')
#abline(v=bndi)

Params_matrix = matrix(data = 0, ncol = 28, nrow = length(bndi))
qq=0
for(it in 2:length(bndi)) {
  #save.wave(s2[bndi[it-1]:bndi[it]],sprintf("seg%d.wav",it-1))
  
  ##################ekstrakcja cech####################  
  
  single_segment = s2[bndi[it-1]:bndi[it]]
  #gdy byly zbyt krotkie probki, to funkcje melfcc i fund wyrzucaja bledy
  if( length(single_segment) < 1000)
    next

  #ENERGIA SYGNALU
  E <- sum((single_segment^2));
  
  #zamiana na inną klase
  save.wave(single_segment, "temp.wav")
  samples <- readWave("temp.wav");

  #MFCC
  m1 <- melfcc(samples, numcep = 26); # - http://www.inside-r.org/packages/cran/tuneR/docs/melfcc
  # w tej funkcji mozna ustalac duzo parametrow, co najwazniejsze - liczbÄ™ wspĂłĹ‚czynnikĂłw mfcc
  for (j in 1:26) {
    Params_matrix[it,j] = mean(m1[,j])
  }

  # http://rug.mnhn.fr/seewave/HTML/MAN/fund.html - przed uzyciem zapoznaj sie z treĹ›ciÄ… helpa lub skonsultuj siÄ™ z cezarym piskor-ignatowiczem.
  #CZESTOTLIWOSC FUNDAMENTALNA - na razie nie dziala
  qq <- fund(samples,f=8000,fmax=300,type="b",ovlp=50,threshold=5,ylim=c(0,1),cex=0.5, plot = FALSE)
  f_fund = mean(qq[,2], na.rm = TRUE)
  if (is.na(f_fund))
    f_fund = 0

  Params_matrix[it,27] = E
  Params_matrix[it,28] = f_fund
}

#Params_matrix = Params_matrix
  params_list<-list("par_matrix"=Params_matrix,"low_pass_filter"=w,"nonoise"=nonoise,
                    "czest_fundamentalna"=qq ,"energ_sygnalu"=E, "finalfreqspec"=finalfreqspec,
                    "nonoise"=nonoise,"nonoisespec"=nonoisespec,"nonoisem"=nonoisem,
                    "preemfazaaudio"=preemfazaaudio,"preemfazaspec"=preemfazaspec,"bndi"=bndi)
  
  # access to list: params_list$element name eg, : params_list$low_pass_filter equal w
}
