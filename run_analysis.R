## IMPORTANT: The "UCI HAR Dataset" folder must be in your working directory

## Read "train" datafiles
path <- "./UCI HAR Dataset/train/"
train.data <- read.table(file = paste0(path, "X_train.txt"))
train.labels <- read.table(file = paste0(path, "y_train.txt"))
train.subjects <- read.table(file = paste0(path, "subject_train.txt"))

## Investigate "train" datafiles
dim(train.data)
str(train.data)
dim(train.labels)
summary(train.labels)
dim(train.subjects)
summary(train.subjects)

## Read "test" datafiles
path <- "./UCI HAR Dataset/test/"
test.data <- read.table(file = paste0(path, "X_test.txt"))
test.labels <- read.table(file = paste0(path, "y_test.txt"))
test.subjects <- read.table(file = paste0(path, "subject_test.txt"))

## Investigate "test" datafiles
dim(test.data)
str(test.data)
dim(test.labels)
summary(test.labels)
dim(test.subjects)
summary(test.subjects)

## Combine test.data with test.subjects
test.data.new <- cbind(test.subjects, test.data)
names(test.data.new)[1] <- "subject"
names(test.data.new)[1] #check

## Combine test.data with test.labels
test.data.new <- cbind(test.labels, test.data.new)
names(test.data.new)[1] <- "labels"
names(test.data.new)[1] #check

## Combine train.data with train.subjects
train.data.new <- cbind(train.subjects, train.data)
names(train.data.new)[1] <- "subject"
names(train.data.new)[1] #check

## Combine train.data with train.labels
train.data.new <- cbind(train.labels, train.data.new)
names(train.data.new)[1] <- "labels"
names(train.data.new)[1] #check

## (1) Merge the training (train.data) and the test (test.data) sets to
## create one data set (all.data)
all.data <- rbind(test.data.new, train.data.new)

## Read "activity labels" and "features" file
path <- "./UCI HAR Dataset/"
activity.labels <- read.table(file = paste0(path, "activity_labels.txt"))
activity.labels
features <- read.table(file = paste0(path, "features.txt"))
features

## (4) Appropriately labels the data set with descriptive variable names.
## Add column headers to data from features
column.headers <- as.character(features[, 2])
names(all.data) <- c("labels", "subject", column.headers)

## (3) Use descriptive activity names to name the activities in the data set.
## Replace label numbers by label descriptions
names(activity.labels) <- c("labels", "activity")
activity.labels
factor(all.data$labels)
all.data <- merge(activity.labels, all.data, by = "labels")

## View content of data
names(all.data)
all.data[10000:10010, 1:3]

## (2) Extract only the measurements on the mean and standard deviation for
## each measurement. Selection of columns containing mean() or std() in 
## header
column.numbers <- c(1, 2, 3, grep("mean\\(\\)|std\\(\\)", names(all.data)))
mean.std.data <- all.data[, column.numbers]
names(mean.std.data)

## (5) Create second tidy data set with the average of each variable for each
## activity and each subject.
data.mean <- aggregate(mean.std.data[, 4:69], by = mean.std.data[, 2:3],
                       FUN = mean)
names(data.mean)
str(data.mean)

## Cross-check: mean of walking, subject 1, tBodyAcc-mean()-X
mean(filter(mean.std.data, subject == 1, label.description == "WALKING")[, 4])
filter(data.mean, subject == 1, label.description == "WALKING")[, 3]

## Write data to txt file
write.table(data.mean, file = "tidy.data.txt", row.name = FALSE)

## Check: Read data from written file to R. Use "check.names = F" to preserve
## column names with brackets
data.mean.check <- read.table("tidy.data.txt", header = T, check.names = F)
names(data.mean.check)
names(data.mean)
class(data.mean$subject)
