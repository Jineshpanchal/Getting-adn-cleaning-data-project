xtest<-read.table(file = "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test//X_test.txt")
ytest<-read.table(file = "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test//y_test.txt")
testsubject <- read.table(file = "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test//subject_test.txt")
xtrain<-read.table(file = "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train//X_train.txt")
ytrain<-read.table(file = "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train//y_train.txt")
trainsubject<-read.table(file = "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train//subject_train.txt")
xbind<-rbind(xtest,xtrain)
ybind<-rbind(ytest,ytrain)
sbind<-rbind(testsubject,trainsubject)
features<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
xbind <- xbind[, mean_and_std_features]
names(xbind) <- features[mean_and_std_features, 2]
activities <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
ybind[, 1] <- activities[ybind[, 1], 2]
names(ybind) <- "activity"
names(sbind) <- "subject"
all_data <- cbind(xbind,ybind,sbind)
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "averages_data.txt", row.name=FALSE)
