# This R Script:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average
#    of each variable for each activity and each subject.

# read test and train data
testset <- read.table("UCI HAR Dataset/test/X_test.txt")
testsetlabels <- read.table("UCI HAR Dataset/test/y_test.txt")
testsubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

trainset <- read.table("UCI HAR Dataset/train/X_train.txt")
trainsetlabels <- read.table("UCI HAR Dataset/train/y_train.txt")
trainsubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

# read feature list and select only the mean and std of the measurements in the dataset.
features <- read.table("UCI HAR Dataset/features.txt")
featureselection <- grep("mean\\(\\)|std\\(\\)", features$V2) 

# (step 1+2) merge into one big data set and select only mean and std of measurements
testdata <- cbind(testsubjects, testsetlabels, testset[ , featureselection ])
traindata <- cbind(trainsubjects, trainsetlabels, trainset[ , featureselection ])
mergeddataset <- rbind(testdata, traindata)
rm(testset,testsetlabels,trainset,trainsetlabels, testsubjects, trainsubjects)

# subjectIDs should be factors (not numbers)
mergeddataset[, 1 ] <- factor(mergeddataset[, 1 ])

# (step 3) read activity labels and replace labels with their descriptive variable name 
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
mergeddataset[, 2 ] <- factor(mergeddataset[, 2 ], levels = activitylabels$V1, labels = activitylabels$V2)

# (step 4) fix columnnames to get descriptive names and add subjectID and activity to the column names
# remove bars and replace function names with there results, so mean() becomes Mean
columnnames <- features$V2[featureselection]
columnnames <- gsub("-","",columnnames)
columnnames <- gsub("mean\\(\\)", "Mean", columnnames)
columnnames <- gsub("std\\(\\)", "Std", columnnames)
columnnames <- c("subjectID", "activity", columnnames)

# add the clean names to the merged data set
names(mergeddataset) <- columnnames

# From the data set in step 4, create a second, independent tidy data set with the average
# of each variable for each activity and each subject. Add "Avg" to measurement column names to indicate
# this is summarized data.
summarydata <- aggregate(mergeddataset[ , 3:68 ], list( mergeddataset$subjectID, mergeddataset$activity ), mean)
avgcolumnnames <- c(columnnames[1:2], paste0(columnnames[ 3:length(columnnames) ],"Avg"))
names(summarydata) <- avgcolumnnames

# output tidy data sets
write.table(mergeddataset, file = "tidydataset.txt", row.name=FALSE)
write.table(summarydata, file = "summarydataset.txt", row.name=FALSE)