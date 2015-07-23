#Script to analyze the data from the UCI HAR Dataset. the analysis is perfomed in several steps that
#will combine then extract data from several files.#
# This is part of the Coursera: Getting and Cleaning Data course; Data Scientist Specialization
# Will require plyr library

##############
# Step 1. Merges the training and the test sets to create one data set.
##############
# Pull out the training data
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Pull out the test data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Merge data sets
x_all <- rbind(x_train, x_test)
y_all <- rbind(y_train, y_test)
subject_all <- rbind(subject_train, subject_test)

##############
# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##############
# Extract Features information from file
features <- read.table("UCI HAR Dataset/features.txt")
# From that file: Change names to something better and pull out targets of 
# interest (mean and standard deviations)
features[,2] = gsub('-mean', ' Mean', features[,2])
features[,2] = gsub('-std', ' SD', features[,2])
features_mean_sd <- grep(" Mean| SD\\(\\)", features[, 2])
# Subset for targets, parsing down to the needed columsn (mean and standard deviations)
x_all <- x_all[,features_mean_sd]
# Take defined column names and replace names with more descriptive ones.
names(x_all) <- features[features_mean_sd, 2]

##############
# Step 3. Uses descriptive activity names to name the activities in the data set 
##############
# Read in information for activities from file
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
# Change values in y to wnat the various activities are
y_all[, 1] <- activities[y_all[, 1], 2]

##############
# Step 4. Appropriately labels the data set with descriptive variable names. 
##############
# Change the single Y column name
names(y_all) <- "Activity"
# Change the single Subject column name
names(subject_all) <- "Subject"

##############
# Step 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject. 
##############
# Merge all the data together into a single data frame through binding of the columns
data <- cbind(y_all, subject_all, x_all)
#Average data across columns based on activity and subject: Note values to average range
# from columns 3-68
averages <- ddply(data, .(Subject, Activity), function(x) colMeans(x[, 3:68]))
# Print output to file
write.table(averages, "UCI_HAR_Dataset_averages.txt", row.name=FALSE)
