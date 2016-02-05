library(reshape2)
zipfile <- "getdata_dataset.zip"
if (!file.exists(zipfile)){
  ziplocation <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(ziplocation, zipfile, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(zipfile) 
}

readzipfile1 <- read.table("UCI HAR Dataset/activity_labels.txt")
readzipfile1[,2] <- as.character(readzipfile1[,2])
readzipfile2 <- read.table("UCI HAR Dataset/features.txt")
readzipfile2[,2] <- as.character(readzipfile2[,2])

# Extract only the data on mean and standard deviation
readzipfile2value <- grep(".*mean.*|.*std.*", readzipfile2[,2])
readzipfile2value.names <- readzipfile2[readzipfile2value,2]
readzipfile2value.names = gsub('-mean', 'Mean', readzipfile2value.names)
readzipfile2value.names = gsub('-std', 'Std', readzipfile2value.names)
readzipfile2value.names <- gsub('[-()]', '', readzipfile2value.names)


# Load the datasets
loaddata1 <- read.table("UCI HAR Dataset/train/X_train.txt")[readzipfile2value]
loaddata1value <- read.table("UCI HAR Dataset/train/Y_train.txt")
loaddata1value2 <- read.table("UCI HAR Dataset/train/subject_train.txt")
loaddata1 <- cbind(loaddata1value2, loaddata1value, loaddata1)

check <- read.table("UCI HAR Dataset/test/X_test.txt")[readzipfile2value]
checkactivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
checksubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
check <- cbind(checksubjects, checkactivities, check)

# merge datasets and add labels
combined <- rbind(loaddata1, check)
colnames(combined) <- c("subject", "activity", readzipfile2value.names)

# turn activities & subjects into factors
combined$activity <- factor(combined$activity, levels = readzipfile1[,1], labels = readzipfile1[,2])
combined$subject <- as.factor(combined$subject)

combined.data <- melt(combined, id = c("subject", "activity"))
combined.mean <- dcast(combined.data, subject + activity ~ variable, mean)

write.table(combined.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
