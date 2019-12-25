## Written by James Johnson

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each 
##    measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.

library(plyr)
library(dplyr)

## load data test data
testData <- read.delim("./UCI HAR Dataset/test/X_test.txt", header = FALSE, 
                       strip.white = TRUE, stringsAsFactors = FALSE)
testData <- as.character(testData$V1)
testData <- gsub("  "," ",testData)
testData <- strsplit(testData, " ")
testData <- as.data.frame(do.call(rbind, testData))
testData <- mutate_if(testData, is.factor, ~ as.numeric(as.character(.x)))

## load data train data
trainData <- read.delim("./UCI HAR Dataset/train/X_train.txt", header = FALSE,
                        strip.white = TRUE, stringsAsFactors = FALSE)
trainData <- as.character(trainData$V1)
trainData <- gsub("  "," ",trainData)
trainData <- strsplit(trainData, " ")
trainData <- as.data.frame(do.call(rbind, trainData))
trainData <- mutate_if(trainData, is.factor, ~ as.numeric(as.character(.x)))

## Load the features list
features <- read.delim("./UCI HAR Dataset/features.txt", header = FALSE,
                       stringsAsFactors = FALSE)
features <- features$V1
features <- lapply(features, function(features) sub("^[[:digit:]]{,3} ", "",
                                                    features))
features <- lapply(features, function(features) gsub("\\(\\)", "",features))

## Add features to datasets
colnames(trainData) <- features
colnames(testData) <- features

#load Activities
testActivities <- read.delim("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
colnames(testActivities) <- "Activity"

trainActivities <- read.delim("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
colnames(trainActivities) <- "Activity"

#load test Subjects
testSubjects <- read.delim("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
colnames(testSubjects) <- "Subjects"

trainSubjects <- read.delim("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
colnames(trainSubjects) <- "Subjects"

#Combine Data and activities
testData <- cbind(testSubjects, testActivities, testData)
trainData <- cbind(trainSubjects, trainActivities, trainData)

#Combine data sets
allData <- rbind(testData, trainData)

## Convert Activity ID's
allData$Activity <- mapvalues(allData$Activity, c(1:6), 
                              c("WALKING", "WALKING UPSTAIRS", 
                                "WALKING DOWNSTAIRS", "SITTING", 
                                "STANDING", "LAYING"))

#Extract Mean/STD subset
meanSTDSub <- allData[, grepl("Subject|Activity|mean|Mean|std", names(allData))]

#Group by Subject and Activity get mean
finalData <- meanSTDSub %>% group_by(Subjects, Activity) %>% 
        summarize_at(.vars = colnames(meanSTDSub[3:88]), .funs = mean)


#Clean up
rm(testActivities)
rm(trainActivities)
rm(testSubjects)
rm(trainSubjects)
rm(features)
rm(trainData)
rm(testData)
detach("package:dplyr", unload = TRUE)
detach("package:plyr", unload = TRUE)