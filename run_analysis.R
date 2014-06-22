library(plyr)

#loading the train data, inclusive the subjects and activities and combining them in a single dataframe
train <- read.csv2("./UCI HAR Dataset/train/X_train.txt", header=F, sep="", as.is=T)
train[,1:561] <- sapply(train[,1:561], as.numeric)
trainSubjects <- read.csv2("./UCI HAR Dataset/train/subject_train.txt", header=F, as.is=T)
trainActivity <- read.csv2("./UCI HAR Dataset/train/y_train.txt", header=F, as.is=T)
train <- cbind(trainSubjects, trainActivity, train)

#loading the test data, inclusive the subjects and activities and combining them in a single dataframe
test <- read.csv2("./UCI HAR Dataset/test/X_test.txt", header=F, sep="", as.is=T)
test[,1:561] <- sapply(test[,1:561], as.numeric)
testSubjects <- read.csv2("./UCI HAR Dataset/test/subject_test.txt", header=F, as.is=T)
testActivity <- read.csv2("./UCI HAR Dataset/test/y_test.txt", header=F, as.is=T)
test <- cbind(testSubjects, testActivity, test)

#combine the train and the test data
alldata <- rbind(train, test)

# load the name of the features of the dataframe, reduce the dataframe that only mean and std columns are kept,
# then label the columns meaningful.
featureDescription <-read.csv2("./UCI HAR Dataset/features.txt", header=F, sep="", as.is=T)
meanOrStdFeatures <- (grepl("mean\\(\\)", featureDescription$V2) | grepl("std\\(\\)", featureDescription$V2))
usfullFeatures <- c(1:2, 2+which(meanOrStdFeatures))
allUsfullData <- alldata[,usfullFeatures]
names(allUsfullData) <- c("subject", "activity", featureDescription$V2[meanOrStdFeatures])

# change the activities column to a factor with meaningful names.
activities <- read.csv2("./UCI HAR Dataset/activity_labels.txt", sep="", header=F, as.is=T)
allUsfullData$activity <- factor(allUsfullData$activity, levels=activities$V1, labels=activities$V2)

# reduce the dataset in such away that for each subject-activity peer the mean of all
# other columns is build.
newDataset <- ddply(allUsfullData, .(subject,activity), numcolwise(mean))

#save the new dataset
write.csv2(newDataset, file="reducedNewDataset.csv")
