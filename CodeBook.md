Code Book for reducedNewDataset.csv
========================================================

This document describes the content of the file reducedNewDataset.csv.

All date of this fileset origin from the UCI machine learning repository http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The data are downloaded from a file create for the coursera course. The file was downloaded on the 21st June 2014 from the url https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .

We did combine the training and test data, which were combined with the subject and activity information. So we did combine the files ./UCI HAR Dataset/train/X_train.txt, ./UCI HAR Dataset/test/X_test.txt, ./UCI HAR Dataset/train/subject_train.txt, ./UCI HAR Dataset/test/subject_test.txt, ./UCI HAR Dataset/train/y_train.txt and ./UCI HAR Dataset/test/y_test.txt. We only keept feature vectors which contain "mean()" or "std()" in their description plus the subject and activity. This results in a dataset with 68 features and 10299 observations.

The activity feature was transformed in a factor with the activity names as described in the ./UCI HAR Dataset/activity_labels.txt.

After that for each activity-subject pair the mean is build. This results in a object with 180 (30 Subjects * 6 Activities) observations and 68 features. The feature names are keept the same as in the original set plus the features "subject" and "activity".

The object is saved with write.csv2 in the standard configuration. Therefore a additional feature with the data.frame row and no name is saved as first column.

