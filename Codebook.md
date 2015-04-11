#CODEBOOK FOR TIDY DATA

###Data Source

Original data are downloaded from the Human Activity Recognition Using Smartphones Data Set located at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data are collected from an experiment where 30 volunteers were divided into two groups, train and test. Each subject performed six activities, (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a smartphone on their waist. Repeated measures from the accelerometer and gyroscope were recorded. These measures were analyzed resulting in 561 measures for each activity for each subject. 

**The original raw data set is provided in separate files as follows:**

-*Activity_labels.txt*- provides descriptive names of the activities performed

-*features.txt*- vector with measure variables= names.  Details can be found in the features_info.txt file available at the data source website.

**For the test group (and the same files also available for the train group):**

-*X_train.txt*- summary measures for each subject

-*Y_train.txt*- identification of activity performed for each record

-*subject_train.txt*- identification of each subject id for each record 

** raw data also includes raw inertial signals for both the test and train groups. These files were ignored for this particular analysis.


###Raw Data Processing Procedure

With the original data set, a second tidyData data set was created following the guidelines set forth in the Getting and Cleaning Data course project. 

The breakdown of manipulations to the original data is as follows:

1. Data files subject_test, X_test, and y_test from the test subfolder are assembled into a test dataset and the same is done with those same respective files for train in the train folder.The test and train datasets are then combined to form a complete dataset with all records from the experiment.

2. The activity_labels file is merged with the dataset to add descriptive names of activitiesto replace numerical identification 1-6.

3. The data table is reshaped from wide to long. The features file is merged to this file so names of measurements are added. This format results in id variables of subject, activity, measureName, and the time varying variable of the value associated with each measure. Decision to collapse different measures into the long format is validated since values for each measure are normalized and comparable.Values of measureName variable are renamed for clarity to include only alphabetic characters. Camelcase format is then implemented for each value for easy reading and analysis.

4. The data set is subsetted to only include records with measure names containing mean or std (standard deviation). Values with frequency of means were excluded.

5. The script finally writes a .txt file containing a tidy data set called tidyData.txt. This final dataset contains a record containing the mean of each measure for each subject for each activity performed. There is only one variable for each column of data and each row is a unique record. The variable names are descriptive and data is ready for future analyses, each a requirement of a tidy data set.


###Contents of the Final Data Set

13140 records with 4 variables

**VARIABLES:**

*Subject*: 30 levels, factor variable, 1-30

*measureName*: 73 levels, factor variable, contains only continuous measures of mean and std (SD) (subsetted from original 561 measurements found in the features.txt file from the original dataset. 

"angletBodyAccJerkMeanGravityMean", "angletBodyAccMeanGravity","angletBodyGyroJerkMeanGravityMean","angletBodyGyroMeanGravityMean","angleXGravityMean","angleYGravityMean","angleZGravityMean","fBodyAccJerkMeanX","fBodyAccJerkMeanY","fBodyAccJerkMeanZ","fBodyAccJerkStdX","fBodyAccJerkStdY","fBodyAccJerkStdZ","fBodyAccMagMean","fBodyAccMagStd","fBodyAccMeanX","fBodyAccMeanY","fBodyAccMeanZ","fBodyAccStdX","fBodyAccStdY","fBodyAccStdZ","fBodyBodyAccJerkMagMean","fBodyBodyAccJerkMagStd","fBodyBodyGyroJerkMagMean","fBodyBodyGyroJerkMagStd","fBodyBodyGyroMagMean","fBodyBodyGyroMagStd","fBodyGyroMeanX","fBodyGyroMeanY","fBodyGyroMeanZ","fBodyGyroStdX","fBodyGyroStdY","fBodyGyroStdZ","tBodyAccJerkMagMean","tBodyAccJerkMagStd","tBodyAccJerkMeanX","tBodyAccJerkMeanY","tBodyAccJerkMeanZ","tBodyAccJerkStdX","tBodyAccJerkStdY","tBodyAccJerkStdZ","tBodyAccMagMean","tBodyAccMagStd","tBodyAccMeanX","tBodyAccMeanY","tBodyAccMeanZ","tBodyAccStdX","tBodyAccStdY","tBodyAccStdZ","tBodyGyroJerkMagMean","tBodyGyroJerkMagStd","tBodyGyroJerkMeanX","tBodyGyroJerkMeanY","tBodyGyroJerkMeanZ","tBodyGyroJerkStdX","tBodyGyroJerkStdY","tBodyGyroJerkStdZ","tBodyGyroMagMean","tBodyGyroMagStd","tBodyGyroMeanX","tBodyGyroMeanY","tBodyGyroMeanZ","tBodyGyroStdX","tBodyGyroStdY","tBodyGyroStdZ","tGravityAccMagMean","tGravityAccMagStd","tGravityAccMeanX","tGravityAccMeanY","tGravityAccMeanZ","tGravityAccStdX","tGravityAccStdY","tGravityAccStdZ"

*activityName*: 6 levels, factor variable: LAYING,SITTING,STANDING, WALKING,WALKING_UPSTAIRS,WALKING_DOWNSTAIRS

*measureValue*: continuous numeric value representing mean of measurement for that particular record (subject, activity, measure).

