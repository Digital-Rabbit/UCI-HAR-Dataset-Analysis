UCI-HAR-Dataset-Analysis
========================================================================
Code that creates a tidy data set from the Human Activity Recognition Using Smartphones Dataset.

Created: 	21 May 2014 by B. Laden


The primary purpose of the run_analysis.r function is to create a tidy data set from  the
Human Activity Recognition Using Smartphones Dataset available from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The script does the following,
* Merges the training and the test sets to create one data set.
* Labels the rows with the subject numbers and the activity the subject was doing when the data were collected (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING)
* Labels the columns with the signals that were collected from the gyro and accelerometer (561 columns of signal data).
* Extracts only the measurements on the mean and standard deviation for each measurement. Then, writes those data to a data table:   "meanAndStandardDev.csv”.
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. Then, writes those data to a data table: ” tidyDataSet.csv"

To run the script from RStudio:
* Download the Human Activity Recognition Using Smartphones Dataset. The dataset should reside in a directory named UCI HAR Dataset.
* Set the working directory to ~UCI HAR Dataset/
* Load the data.table package.
* Run run_analysis.r

After running the script, you can view each of the two data sets in RStudio using the following commands: 
* read.table("meanAndStandardDev.csv", header = TRUE, sep = ",", row.names = 1)
* read.table("tidyDataSet.csv", header = TRUE, sep = ",", row.names = 1)

For more information on the Human Activity Recognition Using Smartphones Dataset see 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
