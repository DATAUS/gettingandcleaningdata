#Getting and Cleaning Data - Course Project
#PART 1
#MERGE THE TRAINING AND TEST DATASETS TO CREATE ONE DATASET
setwd("C:/Users/DAT/Documents/Getting and Cleaning Data/UCI HAR Dataset")
getwd()
#Import training data from five relevant files that have been unzipped into working directory
subjectTrain=read.table("./train/subject_train.txt",header=FALSE) 
xTrain=read.table("./train/x_train.txt",header=FALSE) 
yTrain=read.table("./train/y_train.txt",header=FALSE) 
features=read.table("./features.txt",header=FALSE) 
activityType=read.table("./activity_labels.txt",header=FALSE) 
#Put heading names on the above training data columns 
colnames(activityType)=c("activityId","activityType")
colnames(subjectTrain)="subjectId"
colnames(xTrain)=features[,2] 
colnames(yTrain)="activityId"
#Create the Training dataset by merging subjectTrain, xTrain and yTrain
Trainingdataset=cbind(yTrain,subjectTrain,xTrain)
#Import test data from three relevant files that have been unzipped into working directory
subjectTest=read.table("./test/subject_test.txt",header=FALSE)
xTest=read.table("./test/x_test.txt",header=FALSE)
yTest=read.table("./test/y_test.txt",header=FALSE)
#Put heading names on the above test data columns
colnames(subjectTest)="subjectId"
colnames(xTest)=features[,2] 
colnames(yTest)="activityId"
#Create the Test dataset by merging subjectTest, xTest and yTest
Testdataset = cbind(yTest,subjectTest,xTest)
#Combine the Training and Test datasets to create one dataset
finalData = rbind(Trainingdataset,Testdataset)
#PART 2
#EXTRACT MEAN AND STANDARD DEVIATION VALUES FOR EACH MEASUREMENT
#Create a vector for the column names from the finalData
colNames=colnames(finalData) 
#Extract the measurements of the mean and standard deviation by creating a Logical Vector that contains TRUE values for the ID, mean and stddev columns and FALSE for all of the other values
logicalVector=(grepl("activity..",colNames)|grepl("subject..",colNames)|grepl("-mean..",colNames)&!grepl("-meanFreq..",colNames)&!grepl("mean..-",colNames)|grepl("-std..",colNames)&!grepl("-std()..-",colNames))
#Extract the required data
reqfinalData=finalData[logicalVector==TRUE]
#PART 3
#USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
#Merge the reqfinalData set with the activityType table 
reqfinalData=merge(reqfinalData,activityType,by="activityId",all.x=TRUE)
colNames=colnames(reqfinalData)
#PART 4
#APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE ACTIVITY NAMES
#Tidy up the names of the activities undertaken
for (i in 1:length(colNames)){
  colNames[i]=gsub("\\()","",colNames[i])
  colNames[i]=gsub("-std$","SD",colNames[i])
  colNames[i]=gsub("-mean","Mean",colNames[i])
  colNames[i]=gsub("^(t)","Time",colNames[i])
  colNames[i]=gsub("^(f)","Frequency",colNames[i])
  colNames[i]=gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i]=gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i]=gsub("[Gg]yro","Gyroscopic",colNames[i])
  colNames[i]=gsub("AccMag","Acceleration_Magnitude",colNames[i])
  colNames[i]=gsub("([Bb]odyaccjerkmag)","Body_Acceleration_Jerk_Magnitude",colNames[i])
  colNames[i]=gsub("JerkMag","Jerk_Magnitude",colNames[i])
  colNames[i]=gsub("GyroMag","Gyroscopic_Magnitude",colNames[i])
}
# Rename the columns in the required final dataset
colnames(reqfinalData)=colNames
#PART 5
#CREATE A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT 
#Create a new table and delete the activityType column
reqfinalDataNoActivityType=reqfinalData[,names(reqfinalData)!="activityType"]
#Find the average of each variable by finding the mean of each activity in the new table
tidyData=aggregate(reqfinalDataNoActivityType[,names(reqfinalDataNoActivityType)!=c("activityId","subjectId")],by=list(activityId=reqfinalDataNoActivityType$activityId,subjectId=reqfinalDataNoActivityType$subjectId),mean)
#Apply the descriptive activity names by merging the tidyData with activityType
tidyData=merge(tidyData,activityType,by="activityId",all.x=TRUE)
#Create a text file of the dataset 
write.table(tidyData,"./tidyData.txt",row.names=FALSE)

