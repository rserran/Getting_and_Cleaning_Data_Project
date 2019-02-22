# Code Book for the Coursera Getting and Cleaning Data Project

## Human Activity Recognition Using Smartphones Dataset (Version 1.0)

By: Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

## Experiment Description

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

Main link: https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones

Raw dataset: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

For each record it is provided:

 - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

For this project, I will only use the following files:

 - features measurements (train/X_train.txt, test/X_test.txt)
 - activity labels (train/y_train.txt, test/y_test.txt)
 - subject identifier (train/subject_train.txt, test/subject_test.txt)
 - features list (features.txt, features_info.txt)
 - activity descriptive names (activities_labels.txt)

## Getting the Data

 - Read the train data (X, y, subject) using data.table function fread().
 - Read the test data (X, y, subject) using data.table function fread().
 - Read the activity descriptive names (activities_labels.txt) using data.table function fread().
 - Read the features (features.txt) using data.table function fread().

## Data Manipulation

 - Concatenate train and test read data independently with cbind().
 - Merge the train and test data tables (merge_dt).
 - Assign column name to measurement data.
 - Create a dataset (mean_std_dt) extracting only the mean (mean) and standard deviation (std) for each measurement.

## Tidying the Data

 - Change the activity labels to descriptive names
 - Change dataset labels with descriptive variable names using gsub().
 - Create a second tidy dataset with the average of each variable for each activity and each subject (subject_activity_mean). 

> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE2NzU3NzM0MDksLTEwOTI3MDMyMjIsLT
E4Njc0ODk4NDIsLTE1NDkzMDQzMzcsMjExNjgzMDYzMCwtMjMz
NjcyODIwXX0=
-->