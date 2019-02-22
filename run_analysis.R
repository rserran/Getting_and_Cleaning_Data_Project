## John Hopkins University Getting and Cleaning Data Course Project

## The script will do the following data manipulations
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each
##   measurement.
## 3. Uses descriptive activity names to name the activities in the data set.
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set
##   with the average of each variable for each activity and each subject.

## install package ("data.table")
install.packages("data.table")
library(data.table)

## get dataset file into
if(!file.exists("./data")){dir.create("./data")}
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(file_url, destfile="./data/datasets.zip")
unzip("./data/datasets.zip")

## create data_path to store "UCI HAR Datatset" directory
data_path <- "UCI HAR Dataset"

## read train datasets - fread()
train_subject <- fread(file.path(data_path, "train", "subject_train.txt"), 
                       col.names = c("subject"))
train_data <- fread(file.path(data_path, "train", "X_train.txt"))
train_activity <- fread(file.path(data_path, "train", "y_train.txt"), 
                 col.names = c("activity"))

## concatenate train data tables
train <- cbind(train_subject, train_activity, train_data)

## read test datasets - fread()
test_subject <- fread(file.path(data_path, "test", "subject_test.txt"), 
                       col.names = c("subject"))
test_data <- fread(file.path(data_path, "test", "X_test.txt"))
test_activity <- fread(file.path(data_path, "test", "y_test.txt"), 
                        col.names = c("activity"))

## concatenate test data tables
test <- cbind(test_subject, test_activity, test_data)

## merge train and test data tables (1.)
merge_dt <- rbind(train, test)

## remove train and test data tables
rm(test_activity, test_data, test_subject, train_activity, train_data, train_subject)

## read activity_labels.txt
activity_labels <- fread(file.path(data_path, "activity_labels.txt"), 
                         col.names = c("activity_id", "activity_label"))

## read features.txt
features <- fread(file.path(data_path, "features.txt"), 
                  col.names = c("index", "features_description"))

## assign colunm name to measurements data
colnames(merge_dt) <- c("subject", "activity", features$features_description)

## select only the measurements with mean (mean) and standard deviation (std) (2.)
mean_std_measure <- grepl("subject|activity|mean|std", colnames(merge_dt))
mean_std_dt <- merge_dt[, ..mean_std_measure]

## change the activity labels to descriptive names (3.)
mean_std_dt$activity <- factor(mean_std_dt$activity, levels = activity_labels[, activity_id],
                               labels = activity_labels[, activity_label])

## create dataset with mean_std_dt column names
mean_std_cols <- colnames(mean_std_dt)

## change dataset labels with descriptive variable names using gsub()
mean_std_cols <- gsub("^f", "frequencydomain", mean_std_cols)
mean_std_cols <- gsub("^t", "timedomain", mean_std_cols)
mean_std_cols <- gsub("Acc", "Accelerometer", mean_std_cols)
mean_std_cols <- gsub("Gyro", "Gyroscope", mean_std_cols)
mean_std_cols <- gsub("Mag", "Magnitude", mean_std_cols)
mean_std_cols <- gsub("Freq", "Frequency", mean_std_cols)
mean_std_cols <- gsub("std", "standarddeviation", mean_std_cols)
mean_std_cols <- gsub("BodyBody", "Body", mean_std_cols)
mean_std_cols <- gsub("[()]", "", mean_std_cols)

## use descriptive variable names as column names (4.)
colnames(mean_std_dt) <- mean_std_cols

## create a second tidy dataset with the average of each variable for each activity
## and each subject
install.packages("dplyr")
library(dplyr)

subject_activity_mean <- mean_std_dt %>% group_by(subject, activity) %>% summarise_each(list(~mean))

# save subject_activity_mean to file "tidy_data.txt"
write.table(subject_activity_mean, "tidy_data.txt", row.names = FALSE, quote = FALSE)
