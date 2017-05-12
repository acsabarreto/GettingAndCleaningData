#Load Libraries to mainulate datasets.
library(tidyverse)

#Load Activity Labels to use in Train and Test Datasets
activityLabels <- read.table("Data/activity_labels.txt", stringsAsFactors = FALSE)

#Rename Activity Labels columns to represent the actual columns contents
names(activityLabels) <- c('Activity_ID','activityName')

#Load Features data to be used as column names of train and test datasets
features <- read.csv("Data/features.txt", header = FALSE, sep=" ", stringsAsFactors = FALSE)

#Get only features names to be used as column names of train and test datasets
features <- features$V2

#Load Train DataSet
x_Train <- read.table("Data/X_train.txt", header = FALSE, stringsAsFactors = FALSE)
y_Train <- read.table("Data/y_train.txt", header = FALSE, stringsAsFactors = FALSE)
subTrain <- read.table("Data/subject_train.txt", header = FALSE, stringsAsFactors = FALSE)

#Name the Columns of train data set with features names
colnames(x_Train) <- features

#Name the unique column of the target of dataset
colnames(y_Train) <- c("Activity_ID")

#Name the unique column of the subject train data
colnames(subTrain) <- c("Subject_ID")

#Unifing the Features, Subject and Target datasets of Train in one dataset
Train <- data.frame(x_Train,y_Train,subTrain)

#Remove the base datasets to free memory
rm(x_Train,y_Train,subTrain)

#Load Test DataSet
x_Test <- read.table("Data/X_test.txt", header = FALSE,stringsAsFactors = FALSE)
y_Test <- read.table("Data/y_test.txt", header = FALSE,stringsAsFactors = FALSE)
subTest <- read.table("Data/subject_test.txt", header = FALSE, stringsAsFactors = FALSE)


#Name the Columns of test data set with features names
colnames(x_Test) <- features

#Name the unique column of the target of dataset
colnames(y_Test) <- c("Activity_ID")

#Name the unique column of the subject train data
colnames(subTest) <- c("Subject_ID")

#Unifing the Features, subject and Target datasets of Test in one dataset
Test <- data.frame(x_Test,y_Test,subTest)

# merge the two and get the combined data
Data <- rbind(Train,Test)

#Remove Train and Test Data to free Memory
rm(Train,Test,x_Test,y_Test, subTest)

# End of the point 1 of Assignment

#Select Man and Sts Columns
selectFeatures <- grep('mean|std',features,ignore.case = TRUE)

#Get the Indexes of Features
featureNames <- features[selectFeatures]

#Adds the Activity_ID and Subjext_ID columns to previously selcted columns
selectFeaturesIdx <- c(selectFeatures,562,563)

meanAndStdData <- as.tibble(Data[,selectFeaturesIdx])

# End of point 2 requiring only the mean and standard deviation

#Rename the coloumns in a descriptively form
names(meanAndStdData)<-gsub("^t", "time", names(meanAndStdData))
names(meanAndStdData)<-gsub("^f", "frequency", names(meanAndStdData))
names(meanAndStdData)<-gsub("Acc", "Accelerometer", names(meanAndStdData))
names(meanAndStdData)<-gsub("Gyro", "Gyroscope", names(meanAndStdData))
names(meanAndStdData)<-gsub("Mag", "Magnitude", names(meanAndStdData))
names(meanAndStdData)<-gsub("BodyBody", "Body", names(meanAndStdData))

#Use Descriptive Activity Names
meanAndStdData <- select(inner_join(meanAndStdData,activityLabels),-(Activity_ID))
tidyData <- select(meanAndStdData,Subject_ID,activityName,1:86)
write_csv(tidyData,'Data/TidyData.csv')