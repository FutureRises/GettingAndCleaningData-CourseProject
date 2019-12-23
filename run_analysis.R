## Written by James Johnson

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each 
##    measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.

## load data test data
testData <- read.delim("./UCI HAR Dataset/test/X_test.txt", header = FALSE, 
                       strip.white = TRUE, stringsAsFactors = FALSE)
testData <- as.character(testData$V1)
testData <- gsub("  "," ",testData)
testData <- strsplit(testData, " ")
testData <- as.data.frame(do.call(rbind, testData))

## load data train data
trainData <- read.delim("./UCI HAR Dataset/train/X_train.txt", header = FALSE, 
                        strip.white = TRUE)
trainData <- as.character(trainData$V1)
trainData <- gsub("  "," ",trainData)
trainData <- strsplit(trainData, " ")
trainData <- as.data.frame(do.call(rbind, trainData))

#testSubjects <- read.delim("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
#colnames(testSubjects) <- "Subjects"

#trainSubjects <- read.delim("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
#colnames(trainSubjects) <- "Subjects"

#Combine Data and Subject IDs, and clean up Subject objects
#testData <- cbind(testSubjects, testData)
#trainData <- cbind(trainSubjects, trainData)
#rm(testSubjects)
#rm(trainSubjects)