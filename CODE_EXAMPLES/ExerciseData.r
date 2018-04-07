
##### Loading Libraries #####
library(dplyr)
library(knitr)
library(caret)
library(rpart)
library(randomForest)
library(rpart.plot)
library(rattle)

#Reading trian and test data in .csv format
ExerciseData_Train = read.csv ("C:/Users/Mathad/Desktop/Pratibha/PratibhaH3Tech-DataScienceTrng/Assignment_Projects/Assignment_1/fwprojectassignmentdatascience/pml-training.csv")
ExerciseData_Test = read.csv("C:/Users/Mathad/Desktop/Pratibha/PratibhaH3Tech-DataScienceTrng/Assignment_Projects/Assignment_1/fwprojectassignmentdatascience/pml-testing.csv")

#Verify if the data is loaded in frame
head(ExerciseData_Train)

#Check the numbe rof rows and columns in train dataset and test data sets
dim(ExerciseData_Train)
dim(ExerciseData_Test)


#List the features of Train data and test data
names(ExerciseData_Train)

#CHeck some stats of dataset
summary(ExerciseData_Train)

# target outcome "classe' tp predict
Pred_Var <- ExerciseData_Train[, "classe"]
levels(Pred_Var)

unique(ExerciseData_Train$user_name)

unique(ExerciseData_Train$classe)

unique(ExerciseData_Test$user_name)

######### Data Cleaning ##########

# Selct feature columns which give accelerometer datafrom sensors and remove all other data like time stamp,Window ect belt, forearm, arm, dumbell
filterTrain = grepl("belt|arm|dumbell", names(ExerciseData_Train))
ExerciseData_Train1 <- ExerciseData_Train[, filterTrain]
ExerciseData_Test1 = ExerciseData_Test[, filterTrain]

#Remove Columns with NA values
Training<- ExerciseData_Train1[,colSums(is.na(ExerciseData_Train1))==0]
Testing<- ExerciseData_Test1[,colSums(is.na(ExerciseData_Test1))==0]

##Include outcome variable in training set
Training$classe<- ExerciseData_Train$classe


##partitioned the training dataset in train and test dataset
input_Train<- createDataPartition(Training$classe, p=0.7, list = FALSE)
Train<-Training[input_Train,]
Test<-Training[-input_Train,]

################## Prediction Model Building #################
##### Trying with Random Forest and Decision Tree models #####


####### Random Forest##############

# Set seed to reproduce same results
set.seed(1234)

##### Fit the data to RF model ####
cont <- trainControl(method="cv", number=2, verboseIter=FALSE)
FitRF <- train(classe ~ ., data=Train, method="rf",trControl=cont)

#Predict on the test data set using fitted RFmodel
predrf<-predict(Fitrf, newdata=Test)
cmrf<- confusionMatrix(predrf, Test$classe)
cmrf

############ Decision Tree ##############
FitDT <- rpart(classe ~ ., data=Train, method="class")
fancyRpartPlot(FitDT)

#Predict on the test data set using fitted DT-model
predict_DTree <- predict(FitDT, newdata=Test, type="class")
cmDTree <- confusionMatrix(predict_DTree, Test$classe)
cmDTree


#####TEST DATA Prediction ########

predict_Test <- predict(Fitrf, newdata=ExerciseData_Test)
predict_Test


