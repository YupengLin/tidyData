run_analysis <- function(){
  #setwd("~/DataScience")
  testPath <- "UCI HAR Dataset/train/X_train.txt"
  trainPath <- "UCI HAR Dataset/test/X_test.txt"
  
  testSet <- read.table(testPath)
  trainSet <- read.table(trainPath)
  
  wholeSet <- rbind(testSet,trainSet)
  feature <- read.table("UCI HAR Dataset/features.txt")
 
  index <- grep("[Mm]ean|[Ss]td",feature$V2)
  meanAndStd <- wholeSet[,index]
  colnames(meanAndStd) <- feature[index,"V2"]
  trainAct <- "UCI HAR Dataset/train/y_train.txt"
  testAct <- "UCI HAR Dataset/test/y_test.txt"
  testActDes <- read.table(testAct)
  trainActDes <- read.table(trainAct)
  actDes <- rbind(testActDes,trainActDes)
  
  dataSet <- cbind(actDes,meanAndStd)
  colnames(dataSet)[1] <- "Activity"
  
  dataSet$Activity <-sub("1","WALKING",dataSet$Activity)
  dataSet$Activity <-sub("2","WALKING_UPSTAIRS",dataSet$Activity)
  dataSet$Activity <-sub("3","WALKING_DOWNSTAIRS",dataSet$Activity)
  dataSet$Activity <-sub("4","SITTING",dataSet$Activity)
  dataSet$Activity <-sub("5","STANDING",dataSet$Activity)
  dataSet$Activity <-sub("6","LAYING",dataSet$Activity)
  
  tstSubPath <- "UCI HAR Dataset/test/subject_test.txt"
  trainSubPath <- "UCI HAR Dataset/train/subject_train.txt"
  
  tstSub <- read.table(tstSubPath)
  trainSub <- read.table(trainSubPath)
  subject <- rbind(tstSub,trainSub)
  
  dataSet <- cbind(subject,dataSet)
  colnames(dataSet)[1] <- "Subject"
 
  #Because of the poor support of String operation in group_by and summarize function
  #And I am not very familiar with other advanced method,
  #I have to use the for loop to group_by every single columns
  #In addtion, the colname had to change to "V1" for more easily manipulation
  #The reason for name vector is to set back the original name
 
  sub <- dataSet[,c(1,2,3)]
  colnames(sub)[3] <- "V1"
  subGroup <- group_by(sub,Subject,Activity)
  result <- summarize(subGroup,V1=mean(V1))


  for (i in 4:88){
         sub <- dataSet[,c(1,2,i)]
         colnames(sub)[3] <- "V1"
         subGroup <- group_by(sub,Subject,Activity)
         partResult <- summarize(subGroup,V1=mean(V1))
         result <- cbind(result,partResult[,3])
     }
  nameVector <- colnames(dataSet)[3:88]
  colnames(result)[3:88] <- nameVector
  write.table(result,file="tidyDataSet.txt",row.names=FALSE);
}