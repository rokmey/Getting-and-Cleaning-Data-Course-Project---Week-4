The run_analysis.R script performs the data preparation and then followed by the 5 steps:
  1. Merging the training and the test sets to create one data set.
  2. Extracting only the measurements on the mean and standard deviation for each measurement.
  3. Using descriptive activity names to name the activities in the data set
  4. Appropriately labeling the data set with descriptive activity names.
  5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject.

Download the dataset:
  Dataset downloaded and extracted under the folder called UCI HAR Dataset.

About variables:
x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
X, Y and Subject merge the previous datasets to further analysis.
features contains the correct names for the X dataset, which are applied to the column names stored in

Extracts only the measurements on the mean and standard deviation for each measurement:
TidyData is created by subsetting Merged_Data, selecting only columns: subject, activity and the measurements on the mean and standard deviation (std) for each measurement.

Uses descriptive activity names to name the activities in the data set:
Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the activities variable.

Appropriately labels the data set with descriptive variable names:
activity column in TidyData renamed into activities
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:
FinalData is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.

Export FinalData into FinalData.txt file.
