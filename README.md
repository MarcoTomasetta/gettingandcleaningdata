
Objectives
-----------------

`run_analysis.R` performs the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

run_analysis.R
-----------------

0. It opens the necessary packages as first step, referred to data.table, plyr and dplyr.
1. It downloads the **UCI HAR Dataset** dataset registering the download date and puts the zip file working directrory. After it is downloaded, it unzips the file into the Data folder. 
2. It loads the **train** and **test** data sets referred to the useful variables for the analysis (Subject, Features and Activity) merging in a single DF Dataframe (using `rbind` and `cbind`).
3. It subsets just the *mean* and *standard deviation* from the **features** data set. This is done using `grep`.
4. It gives descriptive labels to activity and to the column names using `merge` and `names`.  
5. It creates the second indipendent tidy dataset with the average of each variable for each subject/activity.

*The R code doesn't contain the ``head``, ``str`` and ``dim`` command used for preview of the intermediate data sets necessary to choose the variables.*
