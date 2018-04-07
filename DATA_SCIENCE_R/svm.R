library(e1071)
library(caTools)
data(iris)
iris$spl=sample.split(iris,SplitRatio=0.7)
train=subset(iris, iris$spl==TRUE)
test=subset(iris, iris$spl==FALSE)
x=train[,-5]
y=train[,5]
svm_model <- svm(Species ~ ., data=train)
table(predict(svm_model, test[,-5]), test[,5])



svm_tune <- tune(svm, train.x=x, train.y=y, kernel="radial", ranges=list(cost=10^(-2:2), gamma=2^(-2:2)))
#tune() gives us the tuned parameters, C and gamma

svm_model_after_tune <- svm(Species ~ ., data=train,method = "C-classification", kernel="radial", cost=1, gamma=0.25)
summary(svm_model_after_tune)
table(predict(svm_model_after_tune, test[,-5]), test[,5])

