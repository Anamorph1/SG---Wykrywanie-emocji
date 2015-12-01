# Author: Michal Maciejewski
# Prepare learning set:
# m - mean
# s - standard deviation
# first index - parameter
# second index - objec type number

p1m1 <- -10
p1m2 <- -15
p1m3 <- 5
p1m4 <- 0

p2m1 <- 15
p2m2 <- 0
p2m3 <- 0
p2m4 <- -10

p3m1 <- 25
p3m2 <- 24
p3m3 <- 25
p3m4 <- 18

p4m1 <- 10
p4m2 <- -5
p4m3 <- -15
p4m4 <- -5

p1s1 <- 1
p1s2 <- 0.5
p1s3 <- 1
p1s4 <- 2

p2s1 <- 3
p2s2 <- 1
p2s3 <- 0.5
p2s4 <- 0.25

p3s1 <- 5
p3s2 <- 2
p3s3 <- 3
p3s4 <- 1

p4s1 <- 2
p4s2 <- 3
p4s3 <- 2
p4s4 <- 0.5

# Above we created parameters (mean and standard deviation) of four parameters of objects
# for four types of objects. Now we create these objects. Number of learning objects of
# type x is given in variable numx.
num1 <- 50
num2 <- 40
num3 <- 75
num4 <- 25

# WARNING
# Here we create matrix of parameters for learning object of all types. This should be
# created in previous step (parametrization of audio samples).
t1p1 <- matrix(rnorm(num1, mean = p1m1, sd = p1s1), num1, 1)
t1p2 <- matrix(rnorm(num1, mean = p2m1, sd = p2s1), num1, 1)
t1p3 <- matrix(rnorm(num1, mean = p3m1, sd = p3s1), num1, 1)
t1p4 <- matrix(rnorm(num1, mean = p4m1, sd = p4s1), num1, 1)

t2p1 <- matrix(rnorm(num2, mean = p1m2, sd = p1s2), num2, 1)
t2p2 <- matrix(rnorm(num2, mean = p2m2, sd = p2s2), num2, 1)
t2p3 <- matrix(rnorm(num2, mean = p3m2, sd = p3s2), num2, 1)
t2p4 <- matrix(rnorm(num2, mean = p4m2, sd = p4s2), num2, 1)

t3p1 <- matrix(rnorm(num3, mean = p1m3, sd = p1s3), num3, 1)
t3p2 <- matrix(rnorm(num3, mean = p2m3, sd = p2s3), num3, 1)
t3p3 <- matrix(rnorm(num3, mean = p3m3, sd = p3s3), num3, 1)
t3p4 <- matrix(rnorm(num3, mean = p4m3, sd = p4s3), num3, 1)

t4p1 <- matrix(rnorm(num4, mean = p1m4, sd = p1s4), num4, 1)
t4p2 <- matrix(rnorm(num4, mean = p2m4, sd = p2s4), num4, 1)
t4p3 <- matrix(rnorm(num4, mean = p3m4, sd = p3s4), num4, 1)
t4p4 <- matrix(rnorm(num4, mean = p4m4, sd = p4s4), num4, 1)

rm(p1m1, p1m2, p1m3, p1m4)
rm(p2m1, p2m2, p2m3, p2m4)
rm(p3m1, p3m2, p3m3, p3m4)
rm(p4m1, p4m2, p4m3, p4m4)

rm(p1s1, p1s2, p1s3, p1s4)
rm(p2s1, p2s2, p2s3, p2s4)
rm(p3s1, p3s2, p3s3, p3s4)
rm(p4s1, p4s2, p4s3, p4s4)

learnA <- cbind(t1p1, t1p2, t1p3, t1p4)
learnB <- cbind(t2p1, t2p2, t2p3, t2p4)
learnC <- cbind(t3p1, t3p2, t3p3, t3p4)
learnD <- cbind(t4p1, t4p2, t4p3, t4p4)

rm(t1p1, t1p2, t1p3, t1p4)
rm(t2p1, t2p2, t2p3, t2p4)
rm(t3p1, t3p2, t3p3, t3p4)
rm(t4p1, t4p2, t4p3, t4p4)

# Above we have four matrixes of parameters for four types of objects (it could be
# more types or less with more or less parameters). Something like that should produce
# previous step with learning samples, so everything below is for the final usage
# (you only have to change some names of variables or strings). So at the end, above code
# should be commented and not used - in other R script should be created objects learnX.

learn_data <- matrix(nrow = 0, ncol = dim(learnA)[2])
colnames(learn_data) <- c("Param1", "Param2", "Param3", "Param4")
learn_data <- rbind(learn_data, rbind(learnA, rbind(learnB, rbind(learnC, learnD))))

# Now we create vector of string types for all types of objects. It's not automatic, so
# you should know how many types of objects with how many parameters you have (you only
# don't have to know how many test objects for each type you have)
learn_states <- structure(c(rep(1L, dim(learnA)[1]),
                            rep(2L, dim(learnB)[1]),
                            rep(3L, dim(learnC)[1]),
                            rep(4L, dim(learnD)[1])),
                          .Label = c("TypeA", "TypeB", "TypeC", "TypeD"), class = "factor")
