# Author: Bartosz Szmit

library("e1071")
train_machine <- function(x, y) {
  # x - matrix of attributes
  # y - vector of classes
  # returns svm_model
  svm_model <- svm(x, y) 
  # print(summary_svm_model)
}

predict_class <- function(svm_model, data) {
  # svm_model - model returned by train_machine function
  # data - matrix of attributes
  predict(svm_model, data)
}