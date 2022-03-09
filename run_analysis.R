# Preparation step. 
     library(dplyr)
     if(!file.exists("./Roksana")){dir.create("./Roksana")}

  # Download the dataset for the project:
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileURL, destfile="./Roksana/Dataset.zip")

  # Unzip dataset to /data directory
      unzip(zipfile = "./Roksana/Dataset.zip")
--------------------------------------------------------------------------------
        
# Step 1.Merging all data frames to create one data set.

  # 1.1 Reading files

    # 1.1.1  Reading training tables:

      x_train <- read.table("./Roksana/UCI HAR Dataset/train/X_train.txt")
      y_train <- read.table("./Roksana/UCI HAR Dataset/train/y_train.txt")
      subject_train <- read.table("./Roksana/UCI HAR Dataset/train/subject_train.txt")

   # 1.1.2 Reading test tables:
      x_test <- read.table("./Roksana/UCI HAR Dataset/test/X_test.txt")
      y_test <- read.table("./Roksana/UCI HAR Dataset/test/y_test.txt")
      subject_test <- read.table("./Roksana/UCI HAR Dataset/test/subject_test.txt")
  
    # 1.1.3 Reading feature vector:
      features <- read.table('./Roksana/UCI HAR Dataset/features.txt')
  
    # 1.1.4 Reading activity labels:
     activities <- read.table('./Roksana/UCI HAR Dataset/activity_labels.txt')
  
  # 1.2 Assigning column names:
  
      colnames(x_train) <- features[,2]
      colnames(y_train) <- "activity"
      colnames(subject_train) <- "subject"
  
      colnames(x_test) <- features[,2] 
      colnames(y_test) <- "activity"
      colnames(subject_test) <- "subject"
  
      colnames(activities) <- c('activity','activityType')
  
  # 1.3 Merging all data in one set:
  
      X <- rbind(x_train, x_test)
      Y <- rbind(y_train, y_test)
      Subject <- rbind(subject_train, subject_test)
      Merged_Data <- cbind(Subject, Y, X)
--------------------------------------------------------------------------------
        
# Step 2.Extracting only the measurements on the mean and standard deviation for each measurement.
  
      TidyData <- Merged_Data %>% select(subject, activity, contains("mean"), contains("std"))
--------------------------------------------------------------------------------
        
# Step 3. Using descriptive activity names to name the activities in the data set.
  
      TidyData$activity <- activities[TidyData$activity, 2]
--------------------------------------------------------------------------------
        
# Step 4. Appropriately labeling the data set with descriptive variable names.

      names(TidyData)[2] = "activity"
      names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
      names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
      names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
      names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
      names(TidyData)<-gsub("^t", "Time", names(TidyData))
      names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
      names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
      names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
      names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
      names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
      names(TidyData)<-gsub("angle", "Angle", names(TidyData))
      names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))
--------------------------------------------------------------------------------
        
# Step 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  # 5.1 Making a second tidy data set
  
        Final_Data <- TidyData %>%
          group_by(subject, activity) %>%
          summarise_all(funs(mean))
  
  # 5.2 Writing second tidy data set in txt file.
  
      write.table(Final_Data, "FinalData.txt", row.name=FALSE)
