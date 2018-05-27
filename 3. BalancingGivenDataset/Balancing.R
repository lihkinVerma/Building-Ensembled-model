
##############################################
#     To red the required data               #
##############################################
library(xlsx)
myRes<- read.xlsx("Resistiant_CGI.xlsx",sheetIndex = 1)
mySen<- read.xlsx("Sensitive_CGI.xlsx",sheetIndex = 1)

##############################################
#     selecting data in patches              #
##############################################
r<- nrow(myRes)
s<- nrow(mySen)
div<-r/s
div<- as.integer(floor(div)) 
typeof(div)
till<- div*s
for( i in seq(1,till,by=s)){
  myBRes<- myRes[ i: (i+s),]
  mydata<- rbind(myBRes, mySen)
  write.csv(mydata, paste0(i,".csv") )
}
i=i+s
myBRes<- myRes[ i:r,]
mydata<- rbind(myBRes, mySen)
write.csv(mydata, paste0(i,".csv") )
