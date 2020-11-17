####Project: Getting and Cleaning Data####

##Librarys##
library(dplyr)
library(readr)
library(stringr)
library(utils)

#It reviews if exist a folder called data in the directory. 
#If it does not exist, it will create one new folder in the actual directory:
if(!file.exists("./data")){
        dir.create("./data")
} 

#file's url and file zip name.
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
name <- "projectdata"

#download and decompress file
download.file(fileUrl,
              destfile = paste0("./data/", name, ".zip"))
unzip(zipfile = paste0("./data/", name, ".zip"), exdir = paste0(getwd(), "./data"))

#1) Merges the training and the test sets to create one data set.

####Reading Data####

 #Training data
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
predictors_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
response_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

 #Test data
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
predictors_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
response_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

 #names and labels
labels_response <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
predictors_names <- read.table("./data/UCI HAR Dataset/features.txt")

####Joining and naming datasets####
 ##Two forms:
  #Union_all with dplyr
subject_complete <- union_all(subject_train, subject_test)
predictors_complete <- union_all(predictors_train, predictors_test)
response_complete <- union_all(response_train, response_test)
   
   #rbind
rbind(subject_train, subject_test) #subject complete
rbind(predictors_train, predictors_test) #predictors complete
rbind(response_train, response_test) #response complete

 ##Rename the variables of the datasets
names(predictors_complete) <- predictors_names$V2
names(response_complete) <- "response"
names(subject_complete) <- "subject"

#2) Extracts only the measurements on the mean and standard deviation for each measurement.
col_mean_and_std <- grep("(mean|std)\\(\\)", names(predictors_complete))
subset_predictors <- predictors_complete[, col_mean_and_std]

 ##Joining all datasets
dataset_complete <- cbind(response_complete, subject_complete, 
                          subset_predictors)

#3) Uses descriptive activity names to name the activities in the data set
  #The argument "labels" must be input in the same order as levels 
  #after removing those in exclude.
dataset_complete$response <- factor(dataset_complete$response, 
                                    labels = labels_response$V2)

#4) Appropriately labels the data set with descriptive variable names.
#t:time; f:frequency; Acc:accelerometer; Gyro:gyroscopy
names(dataset_complete) <- gsub("^[Ff]", "frequency", names(dataset_complete))
names(dataset_complete) <- gsub("[Bb]ody[Bb]ody", "body", names(dataset_complete))
names(dataset_complete) <- gsub("^[Tt]", "time", names(dataset_complete))
names(dataset_complete) <- gsub("[Aa]cc", "accelerometer", names(dataset_complete))
names(dataset_complete) <- gsub("[Gg]yro", "gyroscopy", names(dataset_complete))
names(dataset_complete) <- gsub("[Mm]ag", "magnitude", names(dataset_complete))
names(dataset_complete) <- tolower(names(dataset_complete)) 

#5)From the data set in step 4, creates a second, independent tidy data set with the average 
   #of each variable for each activity and each subject.
tidy_dataset <- dataset_complete%>%
        group_by(response, subject)%>%
        summarise(across(.cols = everything(), .fns = mean, .names = "mean_{.col}"))

#Review the data structure
head(tidy_dataset)
tail(tidy_dataset)
str(tidy_dataset)

#Export file in .txt
getwd()
write.table(tidy_dataset, file = paste0(getwd(), "./data/tidy_dataset.txt"))




