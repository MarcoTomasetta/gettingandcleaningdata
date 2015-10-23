library (data.table) #necessary packages
if(!file.exists("data")){dir.create("data")} # create a data dir and url connection
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dateDownloaded<-date() #register the date of download
download.file(url, destfile="./data/Dataset.zip", method="curl") #download the zip file
unzip(zipfile="./data/Dataset.zip",exdir="./data") #unzip the file
path<-file.path("./data", "UCI HAR Dataset") #assign the path to a vector path
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

