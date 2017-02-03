getwd()

library(reshape2)

## Download the dataset

filename <- "Projectdata.zip"  ## define the zip file name 

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"  ## Zip download file link##

if (!file.exists(filename)){download.file(fileURL, filename, method="curl")}## download the file##

if (!file.exists("UCI HAR Dataset")) { unzip(filename) } # unzip the file##

list.files(path = "./UCI HAR Dataset", pattern = NULL, all.files = FALSE,
           full.names = FALSE, recursive = FALSE,
           ignore.case = FALSE, include.dirs = TRUE, no.. = FALSE) # check the list of files and directories ## 

list.files(path = "./UCI HAR Dataset/test", pattern = NULL, all.files = FALSE,
           full.names = FALSE, recursive = FALSE,
           ignore.case = FALSE, include.dirs = TRUE, no.. = FALSE)  # list the files from subdirectory test##


list.files(path = "./UCI HAR Dataset/train", pattern = NULL, all.files = FALSE            ,full.names = FALSE, recursive = FALSE,
           ignore.case = FALSE, include.dirs = TRUE, no.. = FALSE) # list the files from subdirectory  train##

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt") # read subject file 

subject_test

ActivityLabel <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE) # read activity label file##

str(ActivityLabel) # review AcitvityLabel

featureText <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)# read activity feature file##

str(featureText) # review featureText


finalmeasurement <- grep(".*mean.*|.*std.*", featureText[,2]) # subsetting the featureText containing mean and std
str(finalmeasurement) # review finalmeasurement
finalmeasurement # view the values 

finalmeasurement.names <- featureText[finalmeasurement,2] # subset the featureText containing mean and std

finalmeasurement.names # view the values 

train <- read.table("./UCI HAR Dataset/train/X_train.txt")[finalmeasurement] # subset data from X_train.txt corresponding to finalmeasurement containing mean and std 
trainActivities <- read.table("./UCI HAR Dataset/train/Y_train.txt") 
trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train) # combine tables containing train data 

test <- read.table("./UCI HAR Dataset/test/X_test.txt")[finalmeasurement] # subset data from X_train.txt corresponding to finalmeasurement containing mean and std 
testActivities <- read.table("./UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test) # combine tables containing test data 

allData <- rbind(train,test) # combine test and train data

colnames(allData) <- c("subject", "activity", finalmeasurement.names) # assign column names 

str(allData)

allData$activity <- factor(allData$activity, levels = ActivityLabel[,1], labels = ActivityLabel[,2]) # convert activity column to factor variable with levle and lables arrigned in ActivityLable File

str(allData)

allData$subject <- as.factor(allData$subject) # convert subject to factor variable

str(allData)

allData.melted <- melt(allData, id = c("subject", "activity")) # transform data set for statistical analysis 
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean) # decast function to carryout mean of each variable corresponding to subject and activity 

write.table(allData.mean, "./tidy.txt", row.names = FALSE, quote = FALSE) # creates a data outout in txt format
