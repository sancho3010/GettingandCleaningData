# Human Activity Recognition Using Smartphones Dataset

Human Activity Recognition database was built from a group of 30 volunteers within an age bracket of 19-48 years while performing six quotidian activities, the which were monitored with one smartphone with embedded inertial sensors on your waist.

- Database site and its full description:
[Go to site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

- Here are the data:
[Download file zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Description of the features (predictors)

<div class=text-justify>
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag)." () 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation

## Labels: response (activities) and subjects

- **subjects**: a group of 30 volunteers within an age bracket of 19-48 years.

- **response**: six quotidian activities:

 1. WALKING
 2. WALKING_UPSTAIRS
 3. WALKING_DOWNSTAIRS
 4. SITTING
 5. STANDING
 6. LAYING

## R Script: run_analysis.R

This file contains the getting, manipulation, cleaning and ordering of three principal datasets: `response_complete`, `subject_complete` and `predictors_complete`. These principal datasets were formed as from six datasets initial:

 - Values of the response (activities): `Y_train.txt` and `Y_test.txt`
 - Values of the predictors (features): `X_train.txt` and `X_test.txt`
 - Values of the subjects: `subject_train.txt` and `subject_test.txt`
 
On the other hand, the predictors's names and the levels of the response variable were loaded:

 - Levels of the response (activities): `activity_labels.txt`
 - Names of the predictors(features): `features.txt`
 
In general, the tasks performed were the next:

 1. Checks if exist a folder called data in the directory. If it does not exist, a new folder will be created in the actual directory with that name: `data`
 
 2. Downloads and decompress the file with `download.file` and `unzip` functions.
 
 3. Merges the training and the test sets to create one data set with the `dplyr` package. After reading the data and merging them, their variables were renamed with the help of     the `names` function. 
 
 4. Extracts only the measurements on the mean and standard deviation for each measurement. This was done with the `gsub` function. Subsequently, the output of this function was     passed through the data set `predictors_complete` in order to extract only the variables that contain the measures solicited. Finally, the resulting data sets were joined       with `cbind` function and called:`dataset_complete`.
 
 5. Uses descriptive activity (response) names to name the activities in the data set. This was done with the `factor` function, where the labels' argument was filled out from       `labels_response` data set.
 
 6. Appropriately labels the data set with descriptive variable names. This was done with the `gsub` function, literals and metacharacters.
 
 7. From the `dataset_complete` data set, creates a second, independent tidy data set with the average     of each variable for each activity and each subject. Here, we used the     [dplyr](https://dplyr.tidyverse.org/) package, specifically the functions group_by, summarise, across and everything.
 
 8. Finally, we export the ordered data to the actual directory in a text file.
</div> 

*Note*: the first part of this document (Description of the features) follow of near the `features_info.txt` file.
