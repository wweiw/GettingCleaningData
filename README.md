# Getting and Cleaning Data Course Project

This is about Coursera Data Science Module 3 - Getting and Cleaning Data Course Project

------------

The run_analysis.R script does the following:

Loads both the training and test datasets as well as the activity and feature information into the table objects.

Filter the training and test datasets to only keep columns which reflect a mean or standard deviation.

Organize the feature and subject information accordingly by rename the description and match the data.

Merge the data into a combined set which contains the subject, features and activity data in cleaned format with filename: merged_data.txt.

Finally, creates a tidy dataset that consists of the average (mean) value of each variable for each subject/activity pair.
The end result is shown in the file tidy.txt.

------------

The CodeBook.md file explains:

The steps taken to read, merge, clean the data and eventually output to the desired outcome of tidy data.
