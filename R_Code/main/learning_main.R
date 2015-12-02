########################################## Preprocessing  #######################
rm(list = ls())
library(audio);
library(seewave);
library(tuneR)

source('compute_params.R')
library(stringr);
library(stringi);

cnt<-0;

learn_anger <- matrix(nrow = 0, ncol = 28)
learn_boredom <- matrix(nrow = 0, ncol = 28)
learn_fear <- matrix(nrow = 0, ncol = 28)
learn_joy <- matrix(nrow = 0, ncol = 28)
learn_neutral <- matrix(nrow = 0, ncol = 28)
learn_sadness <- matrix(nrow = 0, ncol = 28)

for(j in 1:4) { 
  nr<-as.character(j)
  s1<-paste('speech/f',nr,sep='')
  
  for(i in 1:5){
    
    s2 <- "ang";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    learn_anger = rbind(learn_anger, Params_matrix)
    cnt=cnt+1;
  }
  for(i in 1:5){
    
    s2 <- "bor";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    #if (name == "speech/f1bor1.wav")
    #  next
    
    Params_matrix = compute_params(name)
    learn_boredom = rbind(learn_boredom, Params_matrix)
    cnt=cnt+1;
  }
  for(i in 1:5){
    
    s2 <- "fea";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    learn_fear = rbind(learn_fear, Params_matrix)
    cnt=cnt+1;
  }
  for(i in 1:5){
    
    s2 <- "joy";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    learn_joy = rbind(learn_joy, Params_matrix)
    cnt=cnt+1;
  }  
  for(i in 1:5){
    
    s2 <- "neu";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    learn_neutral = rbind(learn_neutral, Params_matrix)
    cnt=cnt+1;
  } 
  for(i in 1:5){
    
    s2 <- "sad";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    learn_sadness = rbind(learn_sadness, Params_matrix)
    cnt=cnt+1;
  }
}
for(j in 1:4) { 
  nr<-as.character(j)
  s1<-paste('speech/m',nr,sep='')
  
  for(i in 1:5){
    
    s2 <- "ang";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    learn_anger = rbind(learn_anger, Params_matrix)
    cnt=cnt+1;
  }
  for(i in 1:5){
    
    s2 <- "bor";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    #if (name == "speech/m2bor5.wav")
    #  next
    
    Params_matrix = compute_params(name)
    learn_boredom = rbind(learn_boredom, Params_matrix)
    cnt=cnt+1;
  }
  for(i in 1:5){
    
    s2 <- "fea";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    learn_fear = rbind(learn_fear, Params_matrix)
    cnt=cnt+1;
  }
  for(i in 1:5){
    
    s2 <- "joy";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    learn_joy = rbind(learn_joy, Params_matrix)
    cnt=cnt+1;
  }  
  for(i in 1:5){
    
    s2 <- "neu";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    learn_neutral = rbind(learn_neutral, Params_matrix)
    cnt=cnt+1;
  } 
  for(i in 1:5){
    
    s2 <- "sad";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    #if (name == "speech/m1sad2.wav")
    #  next
    
    Params_matrix = compute_params(name)
    learn_sadness = rbind(learn_sadness, Params_matrix)
    cnt=cnt+1;
  }
}






#po danym cyklu:
#learn_anger = rbind(learn_anger, Params_matrix)


##########po pętli

learn_data <- matrix(nrow = 0, ncol = dim(learn_anger)[2])
#colnames(learn_data) <- c("Param1", "Param2", "Param3", "Param4")
learn_data <- rbind(learn_data, rbind(learn_anger, rbind(learn_boredom, rbind(learn_fear, rbind(learn_joy, rbind(learn_neutral, learn_sadness))))))

learn_states <- structure(c(rep(1L, dim(learn_anger)[1]),
                            rep(2L, dim(learn_boredom)[1]),
                            rep(3L, dim(learn_fear)[1]),
                            rep(4L, dim(learn_joy)[1]),
                            rep(5L, dim(learn_neutral)[1]),
                            rep(6L, dim(learn_sadness)[1])),
                          .Label = c("Anger", "Boredom", "Fear", "Joy", "Neutral", "Sadness"), class = "factor")

source("svm.R")
# Learning machine
svm_machine <- train_machine(learn_data, learn_states)

# You can print information about machine
print(summary(svm_machine))

save(svm_machine, file = 'svm_machine')
end
