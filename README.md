
## Tidy Data Repo
==================================================================

This repository contains R script "run_analysis" which can be used to create a Tidy Dataset using the data collected from  accelerometers from the Samsung Galaxy S smartphone which contains acceleration/angular velocity data of different subjects performing different activities. 
The data can be downloaded from the link "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 


About the Data
======================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 



The Repository includes the following files:
=========================================

* 'README.md' - which gives the general overview, insruction and explanations

* 'run_analysis.R' - the R script which can be used to generate a Tidy Data set containing the average of each of the measures (containg mean or std) across Activities and Subjects.

* 'CodeBook.md' - describes the variables, the data, and any transformations or work that has been performed to clean up the data 

* 'CODEBOOK.pdf' - describes the variables, the data, and any transformations or work that has been performed to clean up the data 


Pre-requisites and Steps: 
===========================

* Download the data set from the link "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip".
* Unzip and place the folder "UCI HAR Dataset" in your working repository.
* Download and Install package "plyr" from R Library using the command > install.packages("plyr")
* Place the file "run_analysis.R" in your working directory
* Source the script using command > source("run_analysis.R")
* Run the function > createTidyDataset()


Output
=========

* The above steps generate a tidy data set "tidy_data.txt" in your working dirctory
* The dataset contains the average of each of the measures (containg mean or std) across Activities and Subjects from the original data set.


Explanation of what script does
=================================

* Step1: Loads the data x_test,y_test,subject_test,_train, y_train, subject_train, features, activity_labels files into dataframes in R with the same name as the file name.
* Step2: Merges all the test data set using cbind(), Merges all the train data set using cbind() and finally Merges both the test and test data set using rbind() into a final data set c_set.
* Step3: Creates a dataframe features_f using function grepl() and subsetting commands which stores the position of all the measures in the previously generated dataset c_set with mean/std in measure name. For measue name I have used the features dataframe which contain the name of all the measures in c_set. 
* Step4: Subsetting c_set using feaures_f to get only those measures with mean or std
* Step5: Merging c_set with activity_labels data set to get the descriptive names of the activities which originally came from y_test and y_train data sets in Step2. The new dataset generated is mergeData.
* Step6: Giving proper descriptive variable names to the measures in mergeData using names() function
* Step7: Using "ddply" to generate a summarized dataset containing the average of each of the measures (containg mean or std) across Activities and Subjects from mergeData dataset. The result is stored in tidy_data dataset.
* Step8: Writing the contents of tidy_data dataset into a text document "tidy_data.txt" in the working directory using write.table() function.



