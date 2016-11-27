## Script for Class 3, Week 4 of Data Science Certification 
## Coursera Course Project - Getting and Cleaning Data

################################################################################
### 0. Understand Data


## Need to set working directory to the directory with the /train and /test directories
### setwd("...../Course3Week4/CourseProject/UCI HAR Dataset") ## Modify argument to the appropriate directory

# Read in Data
## Get all filenames for "test and training files"
filenames_test = dir(recursive = TRUE, pattern = '*test*.txt')
filenames_train = dir(recursive = TRUE, pattern = '*train*.txt')

## Read the data into a list for test and a list for training
datalist_test = lapply(filenames_test, FUN=read.table)
datalist_training = lapply(filenames_train, FUN=read.table)


################################################################################
##IdentifySubjects
subjects_test = datalist_test[10] #2,947 subjects
subjects_train = datalist_training[10] #7,352 subjects


################################################################################
## Identify Activites
activity_labels = read.table("activity_labels.txt") # 6 activites

################################################################################
## IdentifyMeasurements
features = read.table("features.txt") #561 measurements
# Test Data - X
datalist_test[[11]] # File XTest #561 measurements by 2,947 rows  (i.e. 2947 rows and a columns for each 561 measurements)
# Test Data - 
datalist_test[[12]] # The activity each was doing 2,947 rows by 2 columns - [1] is subject and [2] is the activity being performed


## Assign columnnames to datasets
colnames(datalist_test[[11]]) <- features[[2]]
colnames(datalist_training[[11]]) <- features[[2]]
###############################################################################

# 1. Merges the training and the test sets to create one data set.
## Create DataFrame to link subjects to activities and measurements
TestData = data.frame(subjects_test, datalist_test[[12]], datalist_test[[11]])
TrainingData = data.frame(subjects_train, datalist_training[[12]], datalist_training[[11]])

### Merge the training and test datasets (1. Merges the training and the test sets to create one data set.)
complete_consolidated_data = rbind(TestData, TrainingData)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
### Extract Means
meanStdDataFrame <- complete_consolidated_data[, grep("V1|mean|std",colnames(complete_consolidated_data))]

# 3. Bring in the activity names for each observation
### Rename columns 1 and 2 of subset
names(meanStdDataFrame)[1] <- "subjectIndex"
names(meanStdDataFrame)[2] <- "ActivityTypeId"
### Rename columns of activity labels in preparation for merge
names(activity_labels)[1] <-"ActivityTypeId"
names(activity_labels)[2] <-"ActivityName"

### Merge data sets to bring in name for each observation
library(dplyr) # Requires dplyr for inner_join function
df_meanSTDWithActivityNames <- inner_join(meanStdDataFrame,activity_labels, by.x = "ActivityTypeID")

# 4 Add descriptive names for each variable
### Rename t variables with "Time" as prefix and f variables with Frequency as prefix
names(df_meanSTDWithActivityNames) <- gsub("^t", "Time", names(df_meanSTDWithActivityNames))
names(df_meanSTDWithActivityNames) <- gsub("^f", "Frequency", names(df_meanSTDWithActivityNames))

### Update additional abbriveations
names(df_meanSTDWithActivityNames) <- gsub("Acc", "Acceleration", names(df_meanSTDWithActivityNames))
names(df_meanSTDWithActivityNames) <- gsub("Mag", "Magnitude", names(df_meanSTDWithActivityNames))

# 5. Create additional tidy data set with an average of each observation
### Calculate means of all variables by subject and activity
df_meansofAllVariables <- aggregate(df_meanSTDWithActivityNames[1:81], #82 column is non-numeric and does not make sense to have mean calculated on it 
                     by = list(df_meanSTDWithActivityNames$subjectIndex, df_meanSTDWithActivityNames$ActivityName), # group by these two variables 
                     FUN= "mean" ) # apply function "mean"
### Add Descriptive variables for the grouping factors
names(df_meansofAllVariables)[1] <- "subjectIndex"
names(df_meansofAllVariables)[2] <-"ActivityName"

### remove duplicative variables
df_tidy <- cbind(df_meansofAllVariables[,1:2], df_meansofAllVariables[,5:83])

write.table(df_tidy,"GettingAndCleaningDataFinalTidyDataSet.txt")


