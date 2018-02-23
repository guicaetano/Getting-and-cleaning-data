#setting working enviroment and loading libraries

setwd("D:/Users/caetgu/Dropbox/Coursera/Data Cleaning/project")
library(dplyr)

#loading archives

#features (to be used as columns names in the data file)
features <- read.table(".\\UCI HAR Dataset\\features.txt")

#activity label (to be used for converting the activities numbers into description of activities)
act_label <- read.table(".\\UCI HAR Dataset\\activity_labels.txt", col.names = c("act_code", "activity"))

 #test files
    #subjects
subject_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt", col.names = "subject")

    #test activities
test_activites <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt", col.names = "act_code")

    #test data
test_data <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt", col.names = features$V2)

  #train files
    #subjects
subject_train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt", col.names = "subject")

    #train activities
train_activites <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt", col.names = "act_code")

    #train data
train_data <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt", col.names = features$V2)

#selecting measurements with mean or std
test_select<-select(test_data, matches("mean|std"))
train_select<- select(train_data, matches("mean|std"))

#adding the activities and subjects to the data
  #test
test_joined <- cbind(subject_test, test_activites, test_select)
  
  #train
train_joined <- cbind(subject_train, train_activites, train_select)

#merge datasets
merged_data <- rbind(test_joined, train_joined)

#converting the activities labels from numbers to description of activity
merged_data_with_desc <- merge(act_label,merged_data)

#creating tidy dataset
merged_data_with_desc %>% group_by(subject, activity) %>% 
summarise_all(mean)

#creating output
write.table(final_dataset, row.names = FALSE, "project_submission.txt")
