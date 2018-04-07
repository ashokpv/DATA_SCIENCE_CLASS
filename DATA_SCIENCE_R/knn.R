wbcd <- read.csv("C:/Users/IBM_ADMIN/Desktop/IT TRAINING/data.csv", stringsAsFactors = FALSE)
str(wbcd)
wbcd <- wbcd[-1]
table(wbcd$diagnosis)

wbcd$diagnosis<- factor(wbcd$diagnosis, levels = c("B", "M"),
                        labels = c("Benign", "Malignant"))

round(prop.table(table(wbcd$diagnosis)) * 100, digits = 1)
summary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}
normalize(c(1, 2, 3, 4, 5))
normalize(c(10, 20, 30, 40, 50))
wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))
summary(wbcd_n$area_mean)
wbcd_train <- wbcd_n[1:469, ]
wbcd_test <- wbcd_n[470:569, ]
wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels <- wbcd[470:569, 1]
install.packages("class")

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 21)
library(gmodels)

CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq=FALSE)

"The cell percentages in the table indicate the proportion of values that fall into four
categories. The top-left cell indicates the true negative results. These 61 of 100 values
are cases where the mass was benign and the k-NN algorithm correctly identified it
as such. The bottom-right cell indicates the true positive results, where the classifier
and the clinically determined label agree that the mass is malignant. A total of 37 of
100 predictions were true positives.
The cells falling on the other diagonal contain counts of examples where the k-NN
approach disagreed with the true label. The two examples in the lower-left cell are
false negative results"

wbcd_z <- as.data.frame(scale(wbcd[-1]))
summary(wbcd_z$area_mean)
wbcd_train <- wbcd_z[1:469, ]
wbcd_test <- wbcd_z[470:569, ]
wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels <- wbcd[470:569, 1]
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 21)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq = FALSE)
