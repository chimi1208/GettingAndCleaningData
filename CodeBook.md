Codebook for the Course Project

RAW Data provided from the UCI HAR data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Analysis Process and Rationale:
1. Read in and understand the data
Data set was divided into test and train datasets.  
The files are as below (note the test dataset has the same files with less observations 2,947-test vs. 7,352-train):
 "train/Inertial Signals/body_acc_x_train.txt"  "train/Inertial Signals/body_acc_y_train.txt"  "train/Inertial Signals/body_acc_z_train.txt" 
 "train/Inertial Signals/body_gyro_x_train.txt" "train/Inertial Signals/body_gyro_y_train.txt" "train/Inertial Signals/body_gyro_z_train.txt"
 "train/Inertial Signals/total_acc_x_train.txt" "train/Inertial Signals/total_acc_y_train.txt" "train/Inertial Signals/total_acc_z_train.txt"
 "train/subject_train.txt"                      "train/X_train.txt"                            "train/y_train.txt" 

For purposes of this analysis the only files consdered were:
1. "train/subject_train.txt": subjects
2. "train/X_train.txt": Data Set
3. "train/y_train.txt" Data labels

Per the Readme provided by UCI HAR these were the relevant files.

Theese data and the other provided datasets were read into tables for assessment to understand how they related to each other:
Subject files contained the subjects for each dataset
The test data contained 2,947 obervations across 561 variables
The training dataset contained 7,352 across 561 variables. 
Features contained 561 variable definitions
The activites were labeled 1-6.
Activity labels 1-6 were defined in the Activity_labels text file.

The columns within the test and training datasets were then updated to the names provided in the features file.

The test and training datasets were then merged into a consolidated dataset of 10,299 observations (2,947-test + 7,352-training).

For purposes of the project, the columns that calculated mean and standard deviation were then extracted. This was done by identifying
any column that had "mean" or "std" in its column name.  For purposes of this project, these search terms could be anywhere withing 
the column name.

For clarity, certain columns were renamed .......
