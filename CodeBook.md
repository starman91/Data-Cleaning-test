# Course Project 
### Coursera - Getting and Cleaning Data

#### Files List:
run_analysis.R - This is the operational script to analyze the data
CodeBook.md - List of operational parameters and details
README.md - general repository information

#### Required Libraries
The following libraries need to be installed and loaded prior to running this script
* plyr

#### Data Set
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Script Details
#####Step 1: Pull out data from the files and merge likes together
Data Frames: x_train, y_train, subject_train, x_test, y_test, and subject_test is the raw data pertaining to the train or test sets.
The data is read into these frames and then combined into a new frame(s) via row binding into sets called _all, for each type

#####Step 2: Pull only standard deviation and mean from files and store as new data, then clean up headers
Data frames: x_all, features
Using the file features, read into a data frame of the same name, the necesary columns were identified in x_all and then that data set was 
subsetted to the required columns. Also file columns were annotated with the names Mean or SD as indicated 

#####Step 3: Label the rows with the activity
Data Frames: y_all, activities
Using the activities file, read into the data frame of the same name, these are assigned to the row values in y_all

#####Step 4: label the columns correctly
Data frames: y_all, subject_all
Rename each column in each dataframe (there is only one) correctly (e.g. Activity, Subject)

#####Step 5: Bring it all together and print it out
Data frames: data - all of the previous _all frames combined into this frame using a column bind
             averages - the final product
averages is created by using a plry library function ddply by applying an average (col mean) against each of the cells
The final product is the written to a file.

### Output Data File Details
The output data file is a text file called UCI_HAR_Dataset_averages.txt

Column 1 is the subject that was using the device at the time.
Column 2 is the type of activity recorded by the subject
Columns 3-68 is the average of the telemetry data from the X, Y or Z accelerometer axis.

 

