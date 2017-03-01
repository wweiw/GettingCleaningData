#1. Merges the training and the test sets to create one data set.

actTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
feaTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

actTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
feaTest <- read.table("./UCI HAR Dataset/test/y_test.txt") 
subTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

joined_Data <- rbind(actTrain, actTest)
joined_Label <- rbind(feaTrain, feaTest)
joined_Subject <- rbind(subTrain, subTest)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
featuresNames <- read.table("./UCI HAR Dataset/features.txt")

meanStdDIndex <- grep("mean\\(\\)|std\\(\\)", featuresNames[, 2])

joined_Data <- joined_Data[, meanStdDIndex]

names(joined_Data) <- gsub("\\(\\)", "", featuresNames[meanStdDIndex, 2]) # remove "()"
names(joined_Data) <- gsub("mean", "Mean", names(joined_Data)) # capitalize M
names(joined_Data) <- gsub("std", "Std", names(joined_Data)) # capitalize S
names(joined_Data) <- gsub("-", "", names(joined_Data)) # remove "-" in column names 

#3. Uses descriptive activity names to name the activities in the data set
activityNames <- read.table("./UCI HAR Dataset/activity_labels.txt")
activityNames[, 2] <- tolower(gsub("_", "", activityNames[, 2]))

substr(activityNames[2, 2], 8, 8) <- toupper(substr(activityNames[2, 2], 8, 8))
substr(activityNames[3, 2], 8, 8) <- toupper(substr(activityNames[3, 2], 8, 8))

activityLabel <- activityNames[joined_Label[, 1], 2]

joined_Label[, 1] <- activityLabel
names(joined_Label) <- "Activity"

#4. Appropriately labels the data set with descriptive activity names. 
names(joined_Subject) <- "Subject"
cleanedData <- cbind(joined_Subject, joined_Label, joined_Data)
write.table(cleanedData, "merged_data.txt") # write out the first dataset

#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
subjectLen <- length(table(joined_Subject)) #30 subjects
activityLen <- dim(activityNames)[1] #6 activities
columnLen <- dim(cleanedData)[2] #68 columns

result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) # 180 * 68
result <- as.data.frame(result)

colnames(result) <- colnames(cleanedData) # defined column names
row <- 1
for(y in 1:subjectLen) { # from 1 to 30 subjects
  for(z in 1:activityLen) { # from 1 to 6 activities
    result[row, 1] <- sort(unique(joined_Subject)[, 1])[y]
    result[row, 2] <- activityNames[z, 2]
    boolean1 <- y == cleanedData$Subject
    cleanedData$Subject
    boolean2 <- activityNames[z, 2] == cleanedData$Activity
    result[row, 3:columnLen] <- colMeans(cleanedData[boolean1&boolean2, 3:columnLen])
    row <- row + 1
  }
}

# Write out the second,independent tidy data set
write.table(result, "tidy.txt") 
