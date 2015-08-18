# Getting-and-Cleaning-Data
Course Project for Coursera Course "Getting and Cleaning Data". 
The tidy data set "tidydata.txt" and the full data set for the mean and standard deviation "meanstddata.txt" 
are created by sourcing the script "run_analysis.R" in R. 
The script read in the train and test data sets, combine them into one data set, change the variable names to the ones described in the "features.txt" provided in the original directory. Only the means and standard deviations of the measurements are kept in the data. The script also merges the activity and subject of each observation into the data set. The activity is converted from numbers to characters describing what activity it is, based on "activity_labels.txt". The final tidy data set is obtained by averaging each variable within each activity and each subject.
An description of the tidy data set can be found in "CodeBook.md".
