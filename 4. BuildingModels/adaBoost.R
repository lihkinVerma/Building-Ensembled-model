
library(kernlab)
library(ada)

#--------------------------------------------------------------
#      Starting to make models for each dataSubset
#--------------------------------------------------------------
for( i in seq(1,100,by=28)){
  
  modelName <- "AdaBoost"
  InputDataFileName=paste(i,".csv",sep="")
  training = 100      # Defining Training Percentage
  
  dataset <- read.csv(InputDataFileName)      # Read the datafile
  dataset <- dataset[sample(nrow(dataset)),]  # Shuffle the data row wise.
  
  totalDataset <- nrow(dataset)
  
  target  <- names(dataset)[26]   # i.e. Resistant/ sensitive
  waste   <- names(dataset)[1:3]
  inputs <- setdiff(names(dataset),waste)
  inputs <- setdiff(inputs,target)
  length(inputs)
  
  trainDataset <- dataset[1:(totalDataset * training/100),c(inputs, target)]
  
  formula <- as.formula(paste(target, "~", paste(c(inputs), collapse = "+")))
  formula
  
  model <- ksvm(formula, trainDataset, kernel="rbfdot", prob.model=TRUE)
  model <- ada(formula, trainDataset)
  control=rpart::rpart.control(maxdepth=30,
                               cp=0.010000,
                               minsplit=20,
                               xval=10,
                               iter=50)
  model
  
  save.image(file=paste(modelName,i,"-Model.RData",sep=''))
  
}
#--------------------------------------------------------------
#                           END 
#--------------------------------------------------------------