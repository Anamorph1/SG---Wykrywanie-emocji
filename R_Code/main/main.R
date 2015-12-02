rm(list = ls())
library(audio);
library(seewave);
source("svm.R")
source('Segmentation.R')
source('compute_params.R')

load('svm_machine');


Params_matrix = compute_params("f3sad2.wav") #speech/m4fea1.wav")

vector = matrix(data = 0, nrow = 1, ncol = 28)
for(i in 1:28){
  vector[i] = mean(Params_matrix[,i])
}

pred <- predict_class(svm_machine, vector)
print(pred)


end
