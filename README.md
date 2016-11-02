# Getting and Cleaning Data Coursera Course
This is my submission for the final  assignment for the Getting and Cleaning Data course. Here I will explain the script I made, what is does (for details; check the comments in the script) en why the 'tidy data set' is what it is. This data set is described in detail in the file 'CodeBook.md'.

## CodeBook.md
This file contains a description of the tidy data set made by the run-analysis.R-script were done on the raw data. See for transformation details the summary below, and for implementation the comments in the R script.

## run_analysis.R
The script "run_analysis.R" takes the (unzipped) data set from 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

and transforms it into one tidy data set, 'tidydataset.txt', with descriptive labels and a summarized version of this data set called "summarydataset.txt".

The script assumes you have downloaded the file and unzipped it in your work directory. The script does the following:
- The test and training data is read in (subject IDs, activity labels and measurements)
- The feature list is read and features are selected by finding the texts 'mean()' or 'std()' in the feature list.
- The mean and std of the measurements are selected for both training and test data and merged into one big data set
- Both subjectID and activity are converted to factors as these are categories. Also, the correct labels are added to the activity 'classes' such that they are readable and easy to interpret.
- The columnnames of the whole set are cleaned by removing the bars and brackets. 
- After adding these names to the merged data set we have a clean data set ready for analysis.
- A simple analysis is done at the end: a summary of the tidy data set is made. This summary contains an average for all selected measurements for each combination of subjectID and activity.
- Both data sets are then saved to the work directory.