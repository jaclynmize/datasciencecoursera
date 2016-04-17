## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

require("data.table")
require("reshape2")

# Load data files
activity_labels <- read.table("~/Documents/R/UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("~/Documents/R/UCI HAR Dataset/features.txt")[,2]
xtest <- read.table("~/Documents/R/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("~/Documents/R/UCI HAR Dataset/test/Y_test.txt")
test <- read.table("~/Documents/R/UCI HAR Dataset/test/subject_test.txt")

# Extract the mean and standard deviation
remove_features <- grepl("mean|std", features)
names(xtest) = features
xtest = xtest[,remove_features]

# Load activity labels
ytest[,2] = activity_labels[ytest[,1]]
names(ytest) = c("Activity_ID", "Activity_Label")
names(test) = "subject"
test_data <- cbind(as.data.table(test), ytest, xtest)

xtrain <- read.table("~/Documents/R/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("~/Documents/R/UCI HAR Dataset/train/y_train.txt")

train <- read.table("~/Documents/R/UCI HAR Dataset/train/subject_train.txt")

names(xtrain) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
xtrain = xtrain[,remove_features]

# Load activity data
ytrain[,2] = activity_labels[ytrain[,1]]
names(ytrain) = c("Activity_ID", "Activity_Label")
names(train) = "subject"

# Bind data
train_data <- cbind(as.data.table(train), ytrain, xtrain)

# Merge test and train data
data = rbind(test_data, train_data)

id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset using dcast function
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)
write.table(tidy_data, file = "~/Documents/R/tidy_data.txt")
