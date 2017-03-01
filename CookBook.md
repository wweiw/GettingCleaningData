#CookBook for Cleaning the Activity Data

CookBook.md provides explanation about the variables used and the steps taken to process the data cleaning.

The site where data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data for this project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

------------------

run_analysis.R performs the following steps to clean the data:

Read X_train.txt, y_train.txt and subject_train.txt from the "UCI HAR Dataset/train" directory and store in actTrain, feaTrain and subTrain variables respectively.

Read X_test.txt, y_test.txt and subject_test.txt from the "UCI HAR Dataset/test" directory and store in actTest, feaTest and subTest variables respectively.

Concatenate actTest to actTrain to generate joined_Data;
Concatenate feaTest to feaTrain to generate joined_Label; 
concatenate subTest to subTrain to generate joined_Subject.

Read the features.txt file from the "UCI HAR Dataset" directory and store the data in a variable called featuresNames. The measurements on the mean and standard deviation are retrieved. 

Clean the column names of the subset. Remove the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.

Read the activity_labels.txt file from the "UCI HAR Dataset" directory and store the data in a variable called activityNames.

Extracts only the measurements on the mean and standard deviation for each measurement.

Combine the joined_Subject, joined_Label and joined_Data by column to get a new data frame, cleanedData.
Write the full cleaned data out to "merged_data.txt" file.

Lastly generate a second independent tidy data set with the average of each measurement for each activity and each subject.
Write the processed data out to "tidy.txt" file.