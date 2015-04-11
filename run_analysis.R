#download data and required packages
require(data.table)
require(stats)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
download.file(url, "Dataset.zip", method = "curl")
unzip("Dataset.zip", exdir = "activity_data")

#assemble test data with subject and activity variables
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", as.is = TRUE)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", as.is = TRUE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", as.is = TRUE)
test_set <- cbind(subject_test,y_test,X_test) #add subject_test and y_test to X_test

#assemble train data with subject and activity variables
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", as.is = TRUE)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", as.is = TRUE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", as.is = TRUE)
train_set<- cbind(subject_train, y_train, X_train) #add subject_test and y_test to X_train

## combine test and train data files
allrecordsdf <- rbind(test_set, train_set) #all train and test files no labels
numbers<- 1:561
colnames(allrecordsdf) <- c("subject","activityNum",numbers)
dtcomplete <- setDT(allrecordsdf)

#modify activity labels df to prep for merge
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", as.is = TRUE)
setDT(activity_labels)
setnames(activity_labels, names(activity_labels), c("activityNum", "activityName"))

#merge activity labels and add key
dtcomplete2 <-merge(activity_labels, dtcomplete, by="activityNum", all.x=TRUE)
setkey(dtcomplete2,activityNum, activityName, subject)
dtcomplete2$key <- 1:10299

#reshape long to wide 
dtcompleteL <- reshape(dtcomplete2, direction="long", varying=list(names(dtcomplete2)[4:564]), v.names="Value", 
        idvar=c("activityNum","activityName","subject","key"), timevar="measureNum", times= 1:561)

#merge by MeasureNum the dtcompleteL and features file
features <- read.table("./UCI HAR Dataset/features.txt", as.is = TRUE)
colnames(features) <- c("measureNum","measureName")
finaldf <-merge(features, dtcompleteL, by="measureNum", all.x=TRUE)

#extract measurements on mean and sd for each measurement(select measure with mean or std in string)
#use regular expressions to extract rows containing measure values with [Mm]ean or std
containsmeanstd <- grepl('mean[^Freq]|std', finaldf$measureName, ignore.case = TRUE)
finaldfmeanstd <- finaldf[containsmeanstd,]

#label dataset with descriptive variable names
colnames(finaldfmeanstd) <-  c("measureNum","measureName","activityNum","activityName","subject",
                               "key","measureValue")

#use descriptive names to name activites in dataset-remove "-" and "()" from values, convert to camelCase
finaldfmeanstd$measureName <- gsub("\\(|\\)|-|,","",finaldfmeanstd$measureName, ignore.case = TRUE)
finaldfmeanstd$measureName <- gsub("s","S",finaldfmeanstd$measureName, fixed = TRUE)
finaldfmeanstd$measureName <- gsub("m","M",finaldfmeanstd$measureName, fixed = TRUE)
finaldfmeanstd$measureName <- gsub("gr","Gr",finaldfmeanstd$measureName, fixed = TRUE)

#4-remove unnecesary columns and write file for entire complete dataset
finaldfmeanstd <- subset(finaldfmeanstd, select = c(subject, measureName,activityName,measureValue))


#from the dataset in #4, create a second dataset with average of each variable for each 
#activity and each subject

finaldfmeanstd$activityName <- as.factor(finaldfmeanstd$activityName)
finaldfmeanstd$measureName <- as.factor(finaldfmeanstd$measureName)
finaldfmeanstd$subject <- as.factor(finaldfmeanstd$subject)

finaldfjustmeans <- aggregate(measureValue ~ subject + measureName + activityName, finaldfmeanstd, mean)
finaldfjustmeans$activityName <- as.factor(finaldfjustmeans$activityName)
finaldfjustmeans$measureName <- as.factor(finaldfjustmeans$measureName)
finaldfjustmeans$subject <- as.factor(finaldfjustmeans$subject)
write.table(finaldfjustmeans, file = "tidyData.txt")
levels(finaldfjustmeans$measureName)


