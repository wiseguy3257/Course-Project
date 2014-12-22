Course-Project
==============

Getting and Cleansing Data Course Project

The run_analysis.R script completes several functions. Here are the steps the code runs through:

1) Read in test data, train data, and features using "read.table()".
2) Use a for loop for change the activity labels from 1-6 to WALKING, WALKING_UPSTAIRS, etc.
3) Merge test tables together using cbind().
4) Merge train tables together using cbind().
5) Merge both test and train data sets together using rbind().
6) Extract mean and standard deviation data using another for loop and "grepl()".
7) Create "tidy" data set and write to text file.


