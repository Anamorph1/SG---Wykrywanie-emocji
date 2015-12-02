rm(list = ls())
library(audio);
library(seewave);
source("svm.R")
source('Segmentation.R')
source('compute_params.R')

load('svm_machine');

#Params_matrix = compute_params("speech/f2joy3.wav")
params_list= compute_params("speech/f2joy3.wav")
Params_matrix<-params_list$par_matrix;

#wrzucenie parametrow do SVM
pred <- predict_class(svm_machine, Params_matrix)

#znalezienie najczestszej wartosci
pred2 = sort(table(pred),decreasing=TRUE)[1]

res = names(pred2)#rozpoznany obiekt, jako string
probability = pred2/length(pred) #coś na kszalt prawdopodobienstwa

end
