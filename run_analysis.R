#necessary packages
library (data.table) 
library("dplyr")
library("plyr")
# create a data dir and url connection
if(!file.exists("data")){dir.create("data")} 
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#register the date of download
dateDownloaded<-date() 
#download the zip file
download.file(url, destfile="./data/Dataset.zip", method="curl")
#unzip the file
unzip(zipfile="./data/Dataset.zip",exdir="./data") 
#assign the path to a vector path
path<-file.path("./data", "UCI HAR Dataset") 
# now let's read the table we interest and assign 
SubjectTrain <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE) #read Subject train
SubjectTest  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE) #read Subject test
FeaturesTest  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE) #read features test
FeaturesTrain <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE) #read features test
ActivityTest  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE) #read Activity test
ActivityTrain <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE) #read Activity train
# now let's merge the dataframe for test and train in a single dataframe regarding activities, subjects and features
Subject <- rbind(SubjectTrain, SubjectTest)
Activity<- rbind(ActivityTrain, ActivityTest)
Features<- rbind(FeaturesTrain, FeaturesTest)
# let's give names to the variables and merge the data in DF Dataframe
names(Subject)<-c("subject")
names(Activity)<- c("activity")
FeaturesNames <- read.table(file.path(path, "features.txt"),head=FALSE)
names(Features)<- FeaturesNames$V2
Complessive <- cbind(Subject, Activity)
DF <- cbind(Features, Complessive)
#select the names of the features regarding mean and standard deviation
subsetFeaturesNames<-FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
selectedNames<-c(as.character(subsetFeaturesNames), "subject", "activity" )
# subset only mean and standard deviation for each measurement
DF<-subset(DF,select=selectedNames)
# assign the activity labels to vector activityLabels
activityLabels <- read.table(file.path(path, "activity_labels.txt"),header = FALSE)
colnames(activityLabels) <- c("activity", "Activity")
# let's give descriptive labels to activities merging DF with activityLabels
DF<-merge(DF, activityLabels)
# Appropriately labels the data set with descriptive variable names
names(DF)<-gsub("^t", "time", names(DF))
names(DF)<-gsub("^f", "frequency", names(DF))
names(DF)<-gsub("Acc", "Accelerometer", names(DF))
names(DF)<-gsub("Gyro", "Gyroscope", names(DF))
names(DF)<-gsub("Mag", "Magnitude", names(DF))
names(DF)<-gsub("BodyBody", "Body", names(DF))
# let's creates a second, independent tidy data set Data2 with the average of each variable
# for each activity and each subject
Data2<-aggregate(. ~subject + Activity, DF, mean)
Data2<-Data2[order(Data2$subject,Data2$Activity),]
Data2<-select(Data2, -activity)
# let's create a txt file to attach to project answers
write.table(Data2, file = "second_dataset.txt",row.name=FALSE)
