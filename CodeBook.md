# Code Book 
This code book describes variables, data, and any transformations or work  performed to clean up the data. 
These efforts resulted into a clean and tidy dataset - please see [tidy_data.txt](https://github.com/gaukharaya/GettingAndCleaningData/blob/master/tidy_data.txt).

## Feature Selection
The features selected for this database come from the accelerometer and gyroscope three-axial raw signals tAcc-XYZ and tGyro-XYZ. 

* The time domain signals were captured at a constant rate of 50 Hz, prefix 't' denotes time
* The signals were then filtered to remove noise
* The accelaration signal was separated into body and gravity acceleration signals: 
  * tBodyAcc-XYZ
  * tGravityAcc-XYZ
* Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals:
  * tBodyAccJerk-XYZ
  * tBodyGyroJerk-XYZ
* Next, the magnitude of these three-dimensional signals were calculated using the Euclidean form:
  * tBodyAccMag
  * tGravityAccMag
  * tBodyAccJerkMag
  * tBodyGyroMag
  * tBodyGyroJerkMag
* Finally a Fast Fourier Transform (FFT) was applied to some of these signals, prefix 'f' indicates frequency domain signals:
  * fBodyAcc-XYZ
  * fBodyAccJerk-XYZ
  * fBodyGyro-XYZ
  * fBodyAccJerkMag
  * fBodyGyroMag
  * fBodyGyroJerkMag

That leaves us with the following set of signals, suffix '-XYZ' denotes three-axial signals in the X, Y and Z directions:

1. tBodyAcc-XYZ
2. tGravityAcc-XYZ
3. tBodyAccJerk-XYZ
4. tBodyGyro-XYZ
5. tBodyGyroJerk-XYZ
6. tBodyAccMag
7. tGravityAccMag
8. tBodyAccJerkMag
9. tBodyGyroMag
10. tBodyGyroJerkMag
11. fBodyAcc-XYZ
12. fBodyAccJerk-XYZ
13. fBodyGyro-XYZ
14. fBodyAccMag
15. fBodyAccJerkMag
16. fBodyGyroMag
17. fBodyGyroJerkMag

The features were further combined with a variety of estimated variables, such as mean value, standard deviation, largest and smalles value in the set etc. This adds up to over 550 of different indicators in total. The file 'features.txt' lists all of the variables.

## Transformations

* The training and the test sets have been merged to form a single data set
* Out of the broad spectrum of features only the measurements on the mean and standard deviation were considered
* Descriptive activity names and labels were used appropriately to increase data readability
* A separate tidy dataset was created as the final step of data refinement efforts


Feature name adjustment example:

* 'tBodyAcc-mean()-X' has been changed to 'tBodyAcc_mean_X'
* 'tBodyAcc-std()-Z'  has been changed to 'tBodyAcc_std_Z'
* etc.

The transformations are achieved by the script called [run_analysis.R](https://github.com/gaukharaya/GettingAndCleaningData/blob/master/run_analysis.R), which:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
