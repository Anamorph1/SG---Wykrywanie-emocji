#
#Sprawdza poprawnosc odgadywania emocji w probkach z bazy.
#Wszystkie probki maja byc w folderze main/speech/
#

rm(list = ls())
library(audio);
library(seewave);
source("svm.R")
source('Segmentation.R')
source('compute_params.R')

load('svm_machine');
library(stringr);
library(stringi);

cnt<-0;

emo_names = c("Anger","Boredom","Fear","Joy","Neutral","Sadness")
results_anger = matrix(nrow = 0, ncol = 1)
results_boredom = matrix(nrow = 0, ncol = 1)
results_fear = matrix(nrow = 0, ncol = 1)
results_joy = matrix(nrow = 0, ncol = 1)
results_neutral = matrix(nrow = 0, ncol = 1)
results_sadness = matrix(nrow = 0, ncol = 1)


for(j in 1:4) { 
  nr<-as.character(j)
  s1<-paste('speech/f',nr,sep='')
  
  for(i in 1:5){
    
    s2 <- "ang";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    
    pred <- predict_class(svm_machine, Params_matrix)
    pred2 = sort(table(pred),decreasing=TRUE)[1]
    res = names(pred2)
    
    if (is.na(res[1])){
      results_anger = rbind(results_anger, "None")
    }else{
      results_anger = rbind(results_anger, res)
    }
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
    pred <- predict_class(svm_machine, Params_matrix)
    pred2 = sort(table(pred),decreasing=TRUE)[1]
    res = names(pred2)
    
    if (is.na(res[1])){
      results_boredom = rbind(results_boredom, "None")
    }else{
      results_boredom = rbind(results_boredom, res)
    }
    cnt=cnt+1;
  }
  for(i in 1:5){
    
    s2 <- "fea";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    pred <- predict_class(svm_machine, Params_matrix)
    pred2 = sort(table(pred),decreasing=TRUE)[1]
    res = names(pred2)
    
    if (is.na(res[1])){
      results_fear = rbind(results_fear, "None")
    }else{
      results_fear = rbind(results_fear, res)
    }
    cnt=cnt+1;
  }
  for(i in 1:5){
    
    s2 <- "joy";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    pred <- predict_class(svm_machine, Params_matrix)
    pred2 = sort(table(pred),decreasing=TRUE)[1]
    res = names(pred2)
    
    if (is.na(res[1])){
      results_joy = rbind(results_joy, "None")
    }else{
      results_joy = rbind(results_joy, res)
    }
    cnt=cnt+1;
  }  
  for(i in 1:5){
    
    s2 <- "neu";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    pred <- predict_class(svm_machine, Params_matrix)
    pred2 = sort(table(pred),decreasing=TRUE)[1]
    res = names(pred2)
    
    if (is.na(res[1])){
      results_neutral = rbind(results_neutral, "None")
    }else{
      results_neutral = rbind(results_neutral, res)
    }
    cnt=cnt+1;
  } 
  for(i in 1:5){
    
    s2 <- "sad";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    pred <- predict_class(svm_machine, Params_matrix)
    pred2 = sort(table(pred),decreasing=TRUE)[1]
    res = names(pred2)
    
    if (is.na(res[1])){
      results_sadness = rbind(results_sadness, "None")
    }else{
      results_sadness = rbind(results_sadness, res)
    }
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
    
    pred <- predict_class(svm_machine, Params_matrix)
    pred2 = sort(table(pred),decreasing=TRUE)[1]
    res = names(pred2)
    
    if (is.na(res[1])){
      results_anger = rbind(results_anger, "None")
    }else{
      results_anger = rbind(results_anger, res)
    }
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
    pred <- predict_class(svm_machine, Params_matrix)
    pred2 = sort(table(pred),decreasing=TRUE)[1]
    res = names(pred2)
    
    if (is.na(res[1])){
      results_boredom = rbind(results_boredom, "None")
    }else{
      results_boredom = rbind(results_boredom, res)
    }
    cnt=cnt+1;
  }
  for(i in 1:5){
    
    s2 <- "fea";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    pred <- predict_class(svm_machine, Params_matrix)
    pred2 = sort(table(pred),decreasing=TRUE)[1]
    res = names(pred2)
    
    if (is.na(res[1])){
      results_fear = rbind(results_fear, "None")
    }else{
      results_fear = rbind(results_fear, res)
    }
    cnt=cnt+1;
  }
  for(i in 1:5){
    
    s2 <- "joy";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    pred <- predict_class(svm_machine, Params_matrix)
    pred2 = sort(table(pred),decreasing=TRUE)[1]
    res = names(pred2)
    
    if (is.na(res[1])){
      results_joy = rbind(results_joy, "None")
    }else{
      results_joy = rbind(results_joy, res)
    }
    cnt=cnt+1;
  }  
  for(i in 1:5){
    
    s2 <- "neu";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    pred <- predict_class(svm_machine, Params_matrix)
    pred2 = sort(table(pred),decreasing=TRUE)[1]
    res = names(pred2)
    
    if (is.na(res[1])){
      results_neutral = rbind(results_neutral, "None")
    }else{
      results_neutral = rbind(results_neutral, res)
    }
    cnt=cnt+1;
  } 
  for(i in 1:5){
    
    s2 <- "sad";
    
    s3<-as.character(i)
    s4<-".wav"
    name<-paste(s1,s2,s3,s4,sep='')
    Params_matrix = compute_params(name)
    pred <- predict_class(svm_machine, Params_matrix)
    pred2 = sort(table(pred),decreasing=TRUE)[1]
    res = names(pred2)
    
    if (is.na(res[1])){
      results_sadness = rbind(results_sadness, "None")
    }else{
      results_sadness = rbind(results_sadness, res)
    }
    cnt=cnt+1;
  }
}


results <- matrix(nrow = 0, ncol = 0)

results <- cbind(results_anger, cbind(results_boredom, cbind(results_fear, cbind(results_joy, cbind(results_neutral, results_sadness)))))
colnames(results) = emo_names


end
