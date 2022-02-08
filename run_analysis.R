library(tidyverse)
var_names <-
    read_table("UCI HAR Dataset/features.txt", col_names = c("ID", "feature"))
#Create Data frame from test data
subject_test <-
    read_table("UCI HAR Dataset/test/subject_test.txt", col_names = "subject")
activity_test <-
    read_table("UCI HAR Dataset/test/y_test.txt", col_names = "activity")
test_set <-
    read_table("UCI HAR Dataset/test/X_test.txt", col_names = var_names$feature) %>%
    bind_cols(activity_test, subject_test)

#Create Data frame from train data
subject_train <-
    read_table("UCI HAR Dataset/train/subject_train.txt", col_names = "subject")
activity_train <-
    read_table("UCI HAR Dataset/train/y_train.txt", col_names = "activity")
train_set <-
    read_table("UCI HAR Dataset/train/X_train.txt", col_names = var_names$feature) %>%
    bind_cols(activity_train, subject_train)

#Merge two data sets
merged_data <- bind_rows(test_set, train_set)

#Finding mean and std columns
filtered_data <-
    merged_data %>% select(matches("mean|std|activity|subject"))

#Replacing activity # with activity desc
activity_desc <-
    read_table("UCI HAR Dataset/activity_labels.txt",
               col_names = c("level", "activity_desc"))

activity_desc <-
    factor(filtered_data$activity,
           levels = activity_desc$level,
           labels = activity_desc$activity_desc) %>% as.character()
filtered_data$activity <- activity_desc

#tidy data set with the average of each variable
#for each activity and each subject
by_sub_act<- filtered_data %>% group_by(subject,activity) %>% 
    summarize(across(.fns = mean))
by_sub_act



