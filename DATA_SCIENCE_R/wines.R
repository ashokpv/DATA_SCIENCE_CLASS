wine <- read.csv("/home/ash/Machine-Learning-with-R-datasets/winequality-white.csv")
str(wine)
wine_train <- wine[1:3750, ]
wine_test <- wine[3751:4898, ]
install.packages("rpart")
m.rpart <- rpart(quality ~ ., data = wine_train)
m.rpart
library(rpart.plot)
rpart.plot(m.rpart, digits = 3)
rpart.plot(m.rpart, digits = 4, fallen.leaves = TRUE,
           type = 3, extra = 101)

p.rpart <- predict(m.rpart, wine_test)
summary(p.rpart)
summary(wine_test$quality)
cor(p.rpart, wine_test$quality)
MAE <- function(actual, predicted) {
  mean(abs(actual - predicted))
}
MAE(p.rpart, wine_test$quality)
mean(wine_train$quality)
MAE(5.87, wine_test$quality)
library(RWeka)
m.m5p <- M5P(quality ~ ., data = wine_train)