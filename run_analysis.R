# load the package for reshaping data
library(reshape2)

# download and unzip the dataset 
if (!file.exists("getdata_dataset.zip"))
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "getdata_dataset.zip", method = "curl")
if (!file.exists("UCI HAR Dataset")) 
  unzip("getdata_dataset.zip")

# read in subject ID, measurement values, and activity ID in the train dataset
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("UCI HAR Dataset/train/y_train.txt")

# read in subject ID, measurement values, and activity ID in the test dataset
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")

# read in the list of measurement variable names
features <- read.table('UCI HAR Dataset/features.txt')
features[,2] <- as.character(features[,2])

# read in the list of activity names
activity_label <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_label[,2] <- as.character(activity_label[,2])

# change the column names of activity_label to activity id and activity_type
colnames(activity_label) <- c('activity_id', 'activity_type')

# combine the train dataset and the test dataset
all_train <- cbind(train_subject, train_x, train_y)
all_test <- cbind(test_subject, test_x, test_y)
all_data <- rbind(all_train, all_test)

# change the column names of the comined set for all data
colnames(all_data) <- c("subject_id", features[, 2], "activity_id")

# select only columns showing subject ID, mean and std's of measurements, and activity ID
logical_vector <- grepl("subject|mean|std|activity", colnames(all_data))
all_data <-  all_data[, logical_vector]

# replace activity ID with descriptive name
all_data$activity_id <- factor(all_data$activity_id, levels = activity_label[, 1], labels = activity_label[, 2])

# tidy the data set by removing () in column names and making column names readable 
all_data_cols <- colnames(all_data)
all_data_cols <- gsub("[\\(\\)-]", "", all_data_cols)
all_data_cols <- gsub("^f", "frequencyDomain", all_data_cols)
all_data_cols <- gsub("^t", "timeDomain", all_data_cols)
all_data_cols <- gsub("Acc", "Accelerometer", all_data_cols)
all_data_cols <- gsub("Gyro", "Gyroscope", all_data_cols)
all_data_cols <- gsub("Mag", "Magnitude", all_data_cols)
all_data_cols <- gsub("Freq", "Frequency", all_data_cols)
all_data_cols <- gsub("mean", "Mean", all_data_cols)
all_data_cols <- gsub("std", "StandardDeviation", all_data_cols)
all_data_cols <- gsub("subject_id", "subject", all_data_cols)
all_data_cols <- gsub("activity_id", "activity", all_data_cols)
all_data_cols <- gsub("BodyBody", "Body", all_data_cols)
colnames(all_data) <- all_data_cols

# group the tidy data by subject and activity and report the mean 
all_data_melted <- melt(all_data, id = c("subject", "activity"))
all_data_mean <-dcast(all_data_melted, subject + activity ~ variable, mean)

# write out the final tidy data set
write.table(all_data_mean, "all_data_tidy.txt", row.names = FALSE, quote = FALSE)