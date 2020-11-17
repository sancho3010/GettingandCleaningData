# Getting and Cleaning Data
This is a new repository shows the getting, manipulation, cleaning and ordering of three principal data sets.

## Summary of the project
 1. Data sets: You will find them in the `CodeBook.md` at the beginning of the document.
 2. Description of the project: You will find it in the `CodeBook.md`
 2. Analysis: You will find it in the `run_analysis.R` and a full description in the `CodeBook.md` or the following section.
 3. Results: You will find it in the `tidy_dataset.txt`. This is a text file.

## R Script: Analysis

<div class=text-justify>
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
 
 4. Extracts only the measurements on the mean and standard deviation for each measurement. This was      done with the `gsub` function. Subsequently, the output of this             function was passed through the data set `predictors_complete` in order to extract only the variables that contain the measures solicited. Finally, the resulting data           sets were joined with `cbind` function and called: `dataset_complete`.
 
 5. Uses descriptive activity (response) names to name the activities in the data set. This was done with the `factor` function, where the labels' argument was filled out from       `labels_response` data set.
 
 6. Appropriately labels the data set with descriptive variable names. This was done with the `gsub` function, literals and metacharacters.
 
 7. From the `dataset_complete` data set, creates a second, independent tidy data set with the average     of each variable for each activity and each subject. Here, we used the     [dplyr](https://dplyr.tidyverse.org/) package, specifically the functions group_by, summarise, across and everything.
 
 8. Finally, we export the ordered data to the actual directory in a text file.
 
 </div>
