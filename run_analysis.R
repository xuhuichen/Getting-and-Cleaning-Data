# download the data sets.
if(!file.exists("accelerometers.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","accelerometers.zip",method="curl")
  unzip("accelerometers.zip")
}
# read in the two data sets and labels
trainset <- read.table("UCI\ HAR\ Dataset/train/X_train.txt")
testset <- read.table("UCI\ HAR\ Dataset/test/X_test.txt")

## Step 1. 
# combined the two data sets
totalset <- rbind(trainset,testset)

## Step 2.
# find the columns that involves mean and standard deviation for each measurement.
meanstd <- sort(c(grep("std()",features[,2]),grep("mean()",features[,2])))
totalset = totalset[,meanstd]

## Step 4.
# read in the feature names, and name the variables according to the feature names
features <- read.table("UCI\ HAR\ Dataset/features.txt")
names(totalset) = as.character(features[meanstd,2])

## Step 3.
# read in the labels
#trainlabel <- read.table("UCI\ HAR\ Dataset/train/y_train.txt")
#testlabel <- read.table("UCI\ HAR\ Dataset/test/y_test.txt")
totallabel <- rbind(trainlabel,testlabel)
# read in the activity label names, and convert the activity numbers to readable labels
activity_labels <- read.table("UCI\ HAR\ Dataset/activity_labels.txt")
totallabel = as.character(factor(t(totallabel),labels=activity_labels[,2]))
# combine the data set and the activity labels and name the activity column
totalset =cbind(totalset,totallabel)
names(totalset)[ncol(totalset)] = "activity"
# read in the subjects
trainsubject <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt")
testsubject <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt")
totalsubject = rbind(trainsubject,testsubject)
# combine the data set and the subject numbers and name the subject column
totalset =cbind(totalset,totalsubject)
names(totalset)[ncol(totalset)] = "subject"

## Step 5. 
# create the tidy data set
activitysplit = split(totalset,totalset$activity)
subjectsplit = split(totalset,totalset$subject)
activitytable = sapply(activitysplit,function(x) sapply(x[1:(ncol(x)-2)],mean))
subjecttable = sapply(subjectsplit,function(x) sapply(x[1:(ncol(x)-2)],mean))
totaltable = t(cbind(activitytable,subjecttable))

# write out the tidy data set
write.table(totaltable,"tidydata.txt",row.names=FALSE)