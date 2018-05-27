
#----------------------------------------------------------------
#         Loading required libraries
#----------------------------------------------------------------
library(xlsx)
library(randomForest)
library(kernlab)
library(ada)
library(rpart)
library(nnet)
library(randomForest)

a<- c("AdaBoost","DecisionTree","LinearModel","NeuralNet","SVM","randomForest")

for(i in seq(1,100,by=28)){
  for(m in a){
    modelFileName <- paste(m,i,"-Model.RData",sep="")
    testFileName  <-"testData.xlsx" 
    
    load(modelFileName)
    
    TestDataset <- read.xlsx(testFileName,sheetIndex = 1)    # Read the datafile
    
    Predicted <- predict(model, TestDataset)
    
    write.csv(data.frame((TestDataset)[1],(TestDataset)[25],Predicted), file=paste(m,i,"-Testing-Result.csv",sep=''), row.names=FALSE)
    
    cat("\nDone")
  }
}
#--------------------------------------------------------------
#                           END 
#--------------------------------------------------------------