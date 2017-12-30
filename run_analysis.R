library(utils)
library(dplyr)

# If the Samsung dataset isn't unzipped in the working directory, download and unzip it.

if (!("UCI HAR Dataset" %in% dir())) {

  link<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(link,"dataset.zip")
  unzip("dataset.zip")

}

# Load features.txt and activity_labels.txt

features<-read.table(file.path("./UCI HAR Dataset/features.txt"))
activity_labels<-read.table(file.path("./UCI HAR Dataset/activity_labels.txt"))

# Load test files: X_test.txt, y_test.txt, and subject_test.txt.
# Column names for X_test are provided by the "features" data frame.
# Column names for y_test and subject_test are "activity" and "subject," respectively.

X_test<-read.table(file.path("./UCI HAR Dataset/test/X_test.txt"),col.names=features[[2]])
y_test<-read.table(file.path("./UCI HAR Dataset/test/y_test.txt"),col.names="activity")
subject_test<-read.table(file.path("./UCI HAR Dataset/test/subject_test.txt"),col.names="subject")

# Load train files: X_train.txt, y_train.txt, and subject_train.txt.
# Column names for X_train are provided by the "features" data frame.
# Column names for y_train and subject_train are "activity" and "subject," respectively.

X_train<-read.table(file.path("./UCI HAR Dataset/train/X_train.txt"),col.names=features[[2]])
y_train<-read.table(file.path("./UCI HAR Dataset/train/y_train.txt"),col.names="activity")
subject_train<-read.table(file.path("./UCI HAR Dataset/train/subject_train.txt"),col.names="subject")

# Bind X_test, y_test, and subject_test into a single data frame called "test."
# First column is "Subject," second column is "Activity," and the rest of the columns are as described in "features."

test<-cbind(subject_test,y_test,X_test)

# Bind X_train, y_train, and subject_train into a single data frame called "train."
# First column is "Subject," second column is "Activity," and the rest of the columns are as described in "features."

train<-cbind(subject_train,y_train,X_train)

# Bind the rows of "test" and "train" into a single data frame

all_data<-tbl_df(rbind(test,train))

# Use descriptive activity names (from "activity_labels") to name the activities in the data set.

all_data<-mutate(all_data,activity=activity_labels[[2]][activity])

# Extract only the measurements on the mean and standard deviation for each measurement.

mean_std_data<-select(all_data,c(1:2,grep("mean|std",names(all_data))))

# Group mean_std_data by subject and activity in order to find the average of each variable for each activity and each subject.

mean_std_data<-group_by(mean_std_data,subject,activity)

# Summarise mean_std_data to find the average of each variable for each activity and each subject.

mean_std_data_summary<-summarise_all(mean_std_data,mean)

# Write mean_std_data_summary as a text file.

write.table(mean_std_data_summary,"mean_std_data_summary.txt",row.names=FALSE)
