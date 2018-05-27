
library(xlsx)
test<- read.xlsx("TestData.xlsx",sheetIndex = 1)

a<- c("AdaBoost",
      # "DecisionTree",
      "LinearModel",
      # "NeuralNet",
      "SVM",
      "randomForest")
for (m in a){
  result<- test[25]
  
  for(i in seq(1,100,by=28)){
    filename<- paste(m,i,"-Testing-Result.csv",sep="")
	  result<- data.frame(result,read.csv(filename)[3])
  }
  
  Overall<-NULL
  o<- 0
  for(i in seq(1,nrow(result))){
    r<-0
    s<-0
    for(j in seq(2,ncol(result))){
      if(result[i,j]=="Resistiant CGI"){r=r+1}
      else{s=s+1}
    }
    if(r>2){
      Overall<-rbind(Overall,"Resistiant CGI")
      if(result[i,1]=="Resistiant CGI"){o=o+1}
      }
    else{
      Overall<-rbind(Overall,"Sensitive CGI")
      if(result[i,1]=="Sensitive CGI"){o=o+1}
      }
  }
  
  result<- data.frame(result,Overall)
  res<-paste("The Overall Result % for ",m," is : ",(o/nrow(result)*100))
  print(res)
  write.csv(result,file=paste(m,"finalresult.csv"),row.names=FALSE)
}

ens<-test[25]
for(m in a){
  fp=read.csv(paste(m,"finalresult.csv"))
  ens<- data.frame(ens,fp[3])
}

Overall<-NULL
o<- 0
for(i in seq(1,nrow(ens))){
  r<-0
  s<-0
  for(j in seq(2,ncol(ens))){
    if(result[i,j]=="Resistiant CGI"){r=r+1}
    else{s=s+1}
  }
  if(r>=2){
    Overall<-rbind(Overall,"Resistiant CGI")
    if(result[i,1]=="Resistiant CGI"){o=o+1}
  }
  else{
    Overall<-rbind(Overall,"Sensitive CGI")
    if(result[i,1]=="Sensitive CGI"){o=o+1}
  }
}

ensresult<- data.frame(ens,Overall)
write.csv(ensresult,file="Ensembledfinalresult.csv",row.names=FALSE)

res<-paste("The Overall Result % for Ensembled Approach is : ",(o/nrow(ens)*100))
print(res)