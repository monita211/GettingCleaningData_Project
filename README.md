#README

###Project Description

This repo contains elements satisfying the requirements of the Coursera Getting and Cleaning Data class project. The objective of this project is to prepare a tidy data set from the “Human Activity Recognition Using Smartphones Dataset” found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This dataset is the data collected from an experiment in which 30 subjects across two conditions (train and test) performed six activities (WALKING, WALKING_UPSTAIRS,WALKING_DOWNSTAIRS,SITTING,STANDING, and LAYING) while wearing a smart phone on the waist. Measurements were recorded for each instance and summarized into 561 unique measures. Components of this data are stored in multiple text files downloadable at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The predetermined requirements for the script were set forth by the course project guideleines. The guidelines specify creating a script that:

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###How to Run the "run_analysis.R" Script
Ensure the current directory is the working directory. Download script to working directory. Use source(run_analysis.R) to run script.THIS WILL TAKE A FEW MINUTES TO COMPLETE. 

###How to View "tidyDATA.txt"
Once the script is done running, to view the tidy dataset run read.table("./tidyData.txt", header=TRUE)
*Alternatively, download the completed tidyData file from the repo. This is the preferred method as the runing time for the script is rather long.*

###What The Script Does
1.	Initializes data.table and stats packages. Ensure these are installed before running script.
2.	Downloads the entire dataset to the working directory in a sub directory called “UCI HAR Dataset”.
3.	Reads in the data sets necessary to assemble test data including y_test, X_test, subject_test and then all of the files necessary to assemble train data including y_train, X_train, subject_train. The test and train files are created with the cbind function. The y files identify each record’s activity, the X files are the summary data from the phone measurements, and the subject_train column identifies the subject performing the activity. The train and test sets are then combined into a single data set.
4.	Next, the activity_labels file is used to replace activity numbers found in the data table with descriptive names of the activities.
5.	The data table is reshaped from wide to long. The features file is used to merge to this file so names of measurements are added. This format results in id variables of subject and activity and the time varying variable of measureName with an accompanying variable of the value associated with each measure. Measures are collapsed into the long format since values for each measure are normalized and comparable.
6.	The reshaped data table is subsetted to only include records with measure names containing mean or std (standard deviation). Measures including the frequency of the mean are not included as these are not explicitely means.
7.	The script then renames values of the measures to include only alphabetic characters. Camelcase format is then implemented for each value.
8.	The script finally writes a .txt file containing a tidy data set called tidyData.txt. This final dataset contains a record containing the mean of each measure for each subject for each activity performed. There is only one variable for each column of data and each row is a unique record. The variable names are descriptive and data is ready for future analyses, all components of a tidy data set.

**SEE ALSO codebook.md for details on variables, the data, and how data was reshaped to develop the tidyData.txt file**

