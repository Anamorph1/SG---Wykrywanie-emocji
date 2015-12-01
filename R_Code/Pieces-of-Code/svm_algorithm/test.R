# Authors:
# - Bartosz Szmit
# - Michal Maciejewski

rm(list=ls())
source("svm.R")
source("parameters.R")

# Learning machine
svm_machine <- train_machine(learn_data, learn_states)

# You can print information about machine
print(summary(svm_machine))

# Now we create object with some random values of parameters
test <- matrix(nrow = 0, ncol = 4)
colnames(test) <- c("Param1", "Param2", "Param3", "Param4")
test <- rbind(test, c(0, 10, 25, -5))

# Here is the usage of main function. We give her learned svm_machine and vector of parameters
# of object. It could be also a matrix of parameters (in columns) of more than one object
# (in rows). Function is returning type of object for each of row in test vector.
pred <- predict_class(svm_machine, test)
print(pred)

# For more than one object in each call to predict_class
test <- rbind(test, c(-10, 10, 20, 5))
pred <- predict_class(svm_machine, test)
print(pred)
