# GettingandCleaningDataCourseProject

This is the course project for the Getting and Cleaning Data Coursera course. The R script, Project.R, does the following:
1. Get information about the working directory 
2. Creat r object for file name and download url name
3. Download the dataset if it does not already exist in the working directory
4. Unzip the downloaded file and read the list of files in directory ans subdirectory
5. Load the subject, activity and feature info
6. Subsets the feature containing mean and std
7. Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
8. Loads the activity and subject data for each dataset, and merges those columns with the dataset
9. Merges the two datasets
10. Converts the activity and subject columns into factors
11. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
12. The end result is shown in the file Output.txt.
