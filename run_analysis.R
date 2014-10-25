
## The below function can be used to generate a tidy dataset using the data collected from  accelerometers from the Samsung Galaxy S smartphone 
##which contains acceleration/angular velocity data for different subjects performing different activities. 
##The data can be downloaded from the link "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
##and needs to be unzipped and placed in your working directory. Also the function assumes that plyr package is installed in R in your local system.



#Creating function createTidyDataset

createTidyDataset <- function()  {
   
   
   print("Loading Files from working directory")
   
   
   subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")  #Loading Files from working directory
   x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
   y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
   subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
   x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
   y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
   activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
   features<-read.table("UCI HAR Dataset/features.txt")
   
   
   
   print("Activity1: Merging the training and the test sets to create one data set.")
   
   test_set<-cbind(y_test,subject_test,x_test)    #Merging the test sets to create one data set
   train_set<-cbind(y_train,subject_train,x_train)     #Merging the train sets to create one data set
   c_set<-rbind(train_set,test_set)      #Merging the test and train sets to create one single data set - c_set
   
   print("Activity2: Extracting only the measurements on the mean and standard deviation for each measurement")
   
   
   features$Mean<-0   #Creating new column in features to identify which are mean measures
   features$std<-0		#Creating new column in features to identify which are std measures
   
   for (i in 1:561) {  
      features[i,3]<-grepl("mean",features[i,2],ignore.case=TRUE)   #Running for loop with grepl function to identify which are mean measures                           
      
   }
   
   
   for (i in 1:561) {  
      features[i,4]<-grepl("std",features[i,2],ignore.case=TRUE)    #Running for loop with grepl function to identify which are std measures                   
      
   }
   
   
   features$valid<-features$Mean + features$std		
   features_f<-features[(features$valid==1),1]		#Creating a dataframe "features" which stores the position of columns in c_set which are mean or std
   
   features_f<-features_f[1:79]				#Eliminating the last 7 variables as they pertain to angular velocity
   
   features_f<-features_f+2
   features_f<-c(1,2,features_f) #Creating a dataframe "features_f" from "features" which adjusts the position based on AcivityCode,ActivityName and Subject Name
   
   
   c_set<-c_set[,features_f]	#Subsetting from c_set only the measurements of mean and std
   
   
   print("Activity3: Using descriptive activity names to name the activities in the data set")
   
   
   mergeData<-merge(activity_labels,c_set,by.x="V1",by.y="V1",all=TRUE) #Merging activity_labels dataset with c_set to provide descriptive activity names in a new set mergeData
   
   mergeData$V2.x<- gsub("_"," ",mergeData$V2.x) #Subsituting underscore with space in activity labels
   
   print("Activity4: Appropriately labeling the data set with descriptive variable names")
   
   names(mergeData)<-c("ActivityCode",		#Providing descriptive Variable Names to mergeData
                       "ActivityName",
                       "SubjectCode",
                       "MeanofAccelerationofBodyonXAxisofphoneinTimeDomain",
                       "MeanofAccelerationofBodyonYAxisofphoneinTimeDomain",
                       "MeanofAccelerationofBodyonZAxisofphoneinTimeDomain",
                       "StandardDeviationofAccelerationofBodyonXAxisofphoneinTimeDomain",
                       "StandardDeviationofAccelerationofBodyonYAxisofphoneinTimeDomain",
                       "StandardDeviationofAccelerationofBodyonZAxisofphoneinTimeDomain",
                       "MeanofAccelerationofGravityonXAxisofphoneinTimeDomain",
                       "MeanofAccelerationofGravityonYAxisofphoneinTimeDomain",
                       "MeanofAccelerationofGravityonZAxisofphoneinTimeDomain",
                       "StandardDeviationofAccelerationofGravityonXAxisofphoneinTimeDomain",
                       "StandardDeviationofAccelerationofGravityonYAxisofphoneinTimeDomain",
                       "StandardDeviationofAccelerationofGravityonZAxisofphoneinTimeDomain",
                       "MeanofAccelerationofJerkofBodyonXAxisofphoneinTimeDomain",
                       "MeanofAccelerationofJerkofBodyonYAxisofphoneinTimeDomain",
                       "MeanofAccelerationofJerkofBodyonZAxisofphoneinTimeDomain",
                       "StandardDeviationofAccelerationofJerkofBodyonXAxisofphoneinTimeDomain",
                       "StandardDeviationofAccelerationofJerkofBodyonYAxisofphoneinTimeDomain",
                       "StandardDeviationofAccelerationofJerkofBodyonZAxisofphoneinTimeDomain",
                       "MeanofAngularvelocityofBodyonXAxisofphoneinTimeDomain",
                       "MeanofAngularvelocityofBodyonYAxisofphoneinTimeDomain",
                       "MeanofAngularvelocityofBodyonZAxisofphoneinTimeDomain",
                       "StandardDeviationofAngularvelocityofBodyonXAxisofphoneinTimeDomain",
                       "StandardDeviationofAngularvelocityofBodyonYAxisofphoneinTimeDomain",
                       "StandardDeviationofAngularvelocityofBodyonZAxisofphoneinTimeDomain",
                       "MeanofAngularvelocityofJerkofBodyonXAxisofphoneinTimeDomain",
                       "MeanofAngularvelocityofJerkofBodyonYAxisofphoneinTimeDomain",
                       "MeanofAngularvelocityofJerkofBodyonZAxisofphoneinTimeDomain",
                       "StandardDeviationofAngularvelocityofJerkofBodyonXAxisofphoneinTimeDomain",
                       "StandardDeviationofAngularvelocityofJerkofBodyonYAxisofphoneinTimeDomain",
                       "StandardDeviationofAngularvelocityofJerkofBodyonZAxisofphoneinTimeDomain",
                       "MeanofMagnitudeofAccelerationofBodyinTimeDomain",
                       "StandardDeviationofMagnitudeofAccelerationofBodyinTimeDomain",
                       "MeanofMagnitudeofAccelerationofGravityinTimeDomain",
                       "StandardDeviationofMagnitudeofAccelerationofGravityinTimeDomain",
                       "MeanofMagnitudeofAccelerationofJerkofBodyinTimeDomain",
                       "StandardDeviationofMagnitudeofAccelerationofJerkofBodyinTimeDomain",
                       "MeanofMagnitudeofAngularvelocityofBodyinTimeDomain",
                       "StandardDeviationofMagnitudeofAngularvelocityofBodyinTimeDomain",
                       "MeanofMagnitudeofAngularvelocityofJerkofBodyinTimeDomain",
                       "StandardDeviationofMagnitudeofAngularvelocityofJerkofBodyinTimeDomain",
                       "MeanofAccelerationofBodyonXAxisofphoneinFrequencyDomain",
                       "MeanofAccelerationofBodyonYAxisofphoneinFrequencyDomain",
                       "MeanofAccelerationofBodyonZAxisofphoneinFrequencyDomain",
                       "StandardDeviationofAccelerationofBodyonXAxisofphoneinFrequencyDomain",
                       "StandardDeviationofAccelerationofBodyonYAxisofphoneinFrequencyDomain",
                       "StandardDeviationofAccelerationofBodyonZAxisofphoneinFrequencyDomain",
                       "MeanFrequencyofAccelerationofBodyonXAxisofphoneinFrequencyDomain",
                       "MeanFrequencyofAccelerationofBodyonYAxisofphoneinFrequencyDomain",
                       "MeanFrequencyofAccelerationofBodyonZAxisofphoneinFrequencyDomain",
                       "MeanofAccelerationofJerkofBodyonXAxisofphoneinFrequencyDomain",
                       "MeanofAccelerationofJerkofBodyonYAxisofphoneinFrequencyDomain",
                       "MeanofAccelerationofJerkofBodyonZAxisofphoneinFrequencyDomain",
                       "StandardDeviationofAccelerationofJerkofBodyonXAxisofphoneinFrequencyDomain",
                       "StandardDeviationofAccelerationofJerkofBodyonYAxisofphoneinFrequencyDomain",
                       "StandardDeviationofAccelerationofJerkofBodyonZAxisofphoneinFrequencyDomain",
                       "MeanFrequencyofAccelerationofJerkofBodyonXAxisofphoneinFrequencyDomain",
                       "MeanFrequencyofAccelerationofJerkofBodyonYAxisofphoneinFrequencyDomain",
                       "MeanFrequencyofAccelerationofJerkofBodyonZAxisofphoneinFrequencyDomain",
                       "MeanofAngularvelocityofBodyonXAxisofphoneinFrequencyDomain",
                       "MeanofAngularvelocityofBodyonYAxisofphoneinFrequencyDomain",
                       "MeanofAngularvelocityofBodyonZAxisofphoneinFrequencyDomain",
                       "StandardDeviationofAngularvelocityofBodyonXAxisofphoneinFrequencyDomain",
                       "StandardDeviationofAngularvelocityofBodyonYAxisofphoneinFrequencyDomain",
                       "StandardDeviationofAngularvelocityofBodyonZAxisofphoneinFrequencyDomain",
                       "MeanFrequencyofAngularvelocityofBodyonXAxisofphoneinFrequencyDomain",
                       "MeanFrequencyofAngularvelocityofBodyonYAxisofphoneinFrequencyDomain",
                       "MeanFrequencyofAngularvelocityofBodyonZAxisofphoneinFrequencyDomain",
                       "MeanofMagnitudeofAccelerationofBodyinFrequencyDomain",
                       "StandardDeviationofMagnitudeofAccelerationofBodyinFrequencyDomain",
                       "MeanFrequencyofMagnitudeofAccelerationofBodyinFrequencyDomain",
                       "MeanofMagnitudeofAccelerationofJerkofBodyinFrequencyDomain",
                       "StandardDeviationofMagnitudeofAccelerationofJerkofBodyinFrequencyDomain",
                       "MagnitudeofAccelerationofJerkofBodyinFrequencyDomain",
                       "MeanofMagnitudeofAngularvelocityofBodyinFrequencyDomain",
                       "StandardDeviationofMagnitudeofAngularvelocityofBodyinFrequencyDomain",
                       "MeanFrequencyofMagnitudeofAngularvelocityofBodyinFrequencyDomain",
                       "MeanofMagnitudeofAngularvelocityofJerkofBodyinFrequencyDomain",
                       "StandardDeviationofMagnitudeofAngularvelocityofJerkofBodyinFrequencyDomain",
                       "MeanFrequencyofMagnitudeofAngularvelocityofJerkofBodyinFrequencyDomain")
   
   
   print("Activity5: Creating a second, independent tidy data set with the average of each variable for each activity and each subject")
   
   
   library(plyr)
   
   tidy_data<-ddply(mergeData,.(ActivityName,SubjectCode),summarize,		#Creating Summary dataset having average of each of the measures across ActivityName and SubjectName
                    MeanofAccelerationofBodyonXAxisofphoneinTimeDomain=mean(MeanofAccelerationofBodyonXAxisofphoneinTimeDomain),
                    MeanofAccelerationofBodyonYAxisofphoneinTimeDomain=mean(MeanofAccelerationofBodyonYAxisofphoneinTimeDomain),
                    MeanofAccelerationofBodyonZAxisofphoneinTimeDomain=mean(MeanofAccelerationofBodyonZAxisofphoneinTimeDomain),
                    StandardDeviationofAccelerationofBodyonXAxisofphoneinTimeDomain=mean(StandardDeviationofAccelerationofBodyonXAxisofphoneinTimeDomain),
                    StandardDeviationofAccelerationofBodyonYAxisofphoneinTimeDomain=mean(StandardDeviationofAccelerationofBodyonYAxisofphoneinTimeDomain),
                    StandardDeviationofAccelerationofBodyonZAxisofphoneinTimeDomain=mean(StandardDeviationofAccelerationofBodyonZAxisofphoneinTimeDomain),
                    MeanofAccelerationofGravityonXAxisofphoneinTimeDomain=mean(MeanofAccelerationofGravityonXAxisofphoneinTimeDomain),
                    MeanofAccelerationofGravityonYAxisofphoneinTimeDomain=mean(MeanofAccelerationofGravityonYAxisofphoneinTimeDomain),
                    MeanofAccelerationofGravityonZAxisofphoneinTimeDomain=mean(MeanofAccelerationofGravityonZAxisofphoneinTimeDomain),
                    StandardDeviationofAccelerationofGravityonXAxisofphoneinTimeDomain=mean(StandardDeviationofAccelerationofGravityonXAxisofphoneinTimeDomain),
                    StandardDeviationofAccelerationofGravityonYAxisofphoneinTimeDomain=mean(StandardDeviationofAccelerationofGravityonYAxisofphoneinTimeDomain),
                    StandardDeviationofAccelerationofGravityonZAxisofphoneinTimeDomain=mean(StandardDeviationofAccelerationofGravityonZAxisofphoneinTimeDomain),
                    MeanofAccelerationofJerkofBodyonXAxisofphoneinTimeDomain=mean(MeanofAccelerationofJerkofBodyonXAxisofphoneinTimeDomain),
                    MeanofAccelerationofJerkofBodyonYAxisofphoneinTimeDomain=mean(MeanofAccelerationofJerkofBodyonYAxisofphoneinTimeDomain),
                    MeanofAccelerationofJerkofBodyonZAxisofphoneinTimeDomain=mean(MeanofAccelerationofJerkofBodyonZAxisofphoneinTimeDomain),
                    StandardDeviationofAccelerationofJerkofBodyonXAxisofphoneinTimeDomain=mean(StandardDeviationofAccelerationofJerkofBodyonXAxisofphoneinTimeDomain),
                    StandardDeviationofAccelerationofJerkofBodyonYAxisofphoneinTimeDomain=mean(StandardDeviationofAccelerationofJerkofBodyonYAxisofphoneinTimeDomain),
                    StandardDeviationofAccelerationofJerkofBodyonZAxisofphoneinTimeDomain=mean(StandardDeviationofAccelerationofJerkofBodyonZAxisofphoneinTimeDomain),
                    MeanofAngularvelocityofBodyonXAxisofphoneinTimeDomain=mean(MeanofAngularvelocityofBodyonXAxisofphoneinTimeDomain),
                    MeanofAngularvelocityofBodyonYAxisofphoneinTimeDomain=mean(MeanofAngularvelocityofBodyonYAxisofphoneinTimeDomain),
                    MeanofAngularvelocityofBodyonZAxisofphoneinTimeDomain=mean(MeanofAngularvelocityofBodyonZAxisofphoneinTimeDomain),
                    StandardDeviationofAngularvelocityofBodyonXAxisofphoneinTimeDomain=mean(StandardDeviationofAngularvelocityofBodyonXAxisofphoneinTimeDomain),
                    StandardDeviationofAngularvelocityofBodyonYAxisofphoneinTimeDomain=mean(StandardDeviationofAngularvelocityofBodyonYAxisofphoneinTimeDomain),
                    StandardDeviationofAngularvelocityofBodyonZAxisofphoneinTimeDomain=mean(StandardDeviationofAngularvelocityofBodyonZAxisofphoneinTimeDomain),
                    MeanofAngularvelocityofJerkofBodyonXAxisofphoneinTimeDomain=mean(MeanofAngularvelocityofJerkofBodyonXAxisofphoneinTimeDomain),
                    MeanofAngularvelocityofJerkofBodyonYAxisofphoneinTimeDomain=mean(MeanofAngularvelocityofJerkofBodyonYAxisofphoneinTimeDomain),
                    MeanofAngularvelocityofJerkofBodyonZAxisofphoneinTimeDomain=mean(MeanofAngularvelocityofJerkofBodyonZAxisofphoneinTimeDomain),
                    StandardDeviationofAngularvelocityofJerkofBodyonXAxisofphoneinTimeDomain=mean(StandardDeviationofAngularvelocityofJerkofBodyonXAxisofphoneinTimeDomain),
                    StandardDeviationofAngularvelocityofJerkofBodyonYAxisofphoneinTimeDomain=mean(StandardDeviationofAngularvelocityofJerkofBodyonYAxisofphoneinTimeDomain),
                    StandardDeviationofAngularvelocityofJerkofBodyonZAxisofphoneinTimeDomain=mean(StandardDeviationofAngularvelocityofJerkofBodyonZAxisofphoneinTimeDomain),
                    MeanofMagnitudeofAccelerationofBodyinTimeDomain=mean(MeanofMagnitudeofAccelerationofBodyinTimeDomain),
                    StandardDeviationofMagnitudeofAccelerationofBodyinTimeDomain=mean(StandardDeviationofMagnitudeofAccelerationofBodyinTimeDomain),
                    MeanofMagnitudeofAccelerationofGravityinTimeDomain=mean(MeanofMagnitudeofAccelerationofGravityinTimeDomain),
                    StandardDeviationofMagnitudeofAccelerationofGravityinTimeDomain=mean(StandardDeviationofMagnitudeofAccelerationofGravityinTimeDomain),
                    MeanofMagnitudeofAccelerationofJerkofBodyinTimeDomain=mean(MeanofMagnitudeofAccelerationofJerkofBodyinTimeDomain),
                    StandardDeviationofMagnitudeofAccelerationofJerkofBodyinTimeDomain=mean(StandardDeviationofMagnitudeofAccelerationofJerkofBodyinTimeDomain),
                    MeanofMagnitudeofAngularvelocityofBodyinTimeDomain=mean(MeanofMagnitudeofAngularvelocityofBodyinTimeDomain),
                    StandardDeviationofMagnitudeofAngularvelocityofBodyinTimeDomain=mean(StandardDeviationofMagnitudeofAngularvelocityofBodyinTimeDomain),
                    MeanofMagnitudeofAngularvelocityofJerkofBodyinTimeDomain=mean(MeanofMagnitudeofAngularvelocityofJerkofBodyinTimeDomain),
                    StandardDeviationofMagnitudeofAngularvelocityofJerkofBodyinTimeDomain=mean(StandardDeviationofMagnitudeofAngularvelocityofJerkofBodyinTimeDomain),
                    MeanofAccelerationofBodyonXAxisofphoneinFrequencyDomain=mean(MeanofAccelerationofBodyonXAxisofphoneinFrequencyDomain),
                    MeanofAccelerationofBodyonYAxisofphoneinFrequencyDomain=mean(MeanofAccelerationofBodyonYAxisofphoneinFrequencyDomain),
                    MeanofAccelerationofBodyonZAxisofphoneinFrequencyDomain=mean(MeanofAccelerationofBodyonZAxisofphoneinFrequencyDomain),
                    StandardDeviationofAccelerationofBodyonXAxisofphoneinFrequencyDomain=mean(StandardDeviationofAccelerationofBodyonXAxisofphoneinFrequencyDomain),
                    StandardDeviationofAccelerationofBodyonYAxisofphoneinFrequencyDomain=mean(StandardDeviationofAccelerationofBodyonYAxisofphoneinFrequencyDomain),
                    StandardDeviationofAccelerationofBodyonZAxisofphoneinFrequencyDomain=mean(StandardDeviationofAccelerationofBodyonZAxisofphoneinFrequencyDomain),
                    MeanFrequencyofAccelerationofBodyonXAxisofphoneinFrequencyDomain=mean(MeanFrequencyofAccelerationofBodyonXAxisofphoneinFrequencyDomain),
                    MeanFrequencyofAccelerationofBodyonYAxisofphoneinFrequencyDomain=mean(MeanFrequencyofAccelerationofBodyonYAxisofphoneinFrequencyDomain),
                    MeanFrequencyofAccelerationofBodyonZAxisofphoneinFrequencyDomain=mean(MeanFrequencyofAccelerationofBodyonZAxisofphoneinFrequencyDomain),
                    MeanofAccelerationofJerkofBodyonXAxisofphoneinFrequencyDomain=mean(MeanofAccelerationofJerkofBodyonXAxisofphoneinFrequencyDomain),
                    MeanofAccelerationofJerkofBodyonYAxisofphoneinFrequencyDomain=mean(MeanofAccelerationofJerkofBodyonYAxisofphoneinFrequencyDomain),
                    MeanofAccelerationofJerkofBodyonZAxisofphoneinFrequencyDomain=mean(MeanofAccelerationofJerkofBodyonZAxisofphoneinFrequencyDomain),
                    StandardDeviationofAccelerationofJerkofBodyonXAxisofphoneinFrequencyDomain=mean(StandardDeviationofAccelerationofJerkofBodyonXAxisofphoneinFrequencyDomain),
                    StandardDeviationofAccelerationofJerkofBodyonYAxisofphoneinFrequencyDomain=mean(StandardDeviationofAccelerationofJerkofBodyonYAxisofphoneinFrequencyDomain),
                    StandardDeviationofAccelerationofJerkofBodyonZAxisofphoneinFrequencyDomain=mean(StandardDeviationofAccelerationofJerkofBodyonZAxisofphoneinFrequencyDomain),
                    MeanFrequencyofAccelerationofJerkofBodyonXAxisofphoneinFrequencyDomain=mean(MeanFrequencyofAccelerationofJerkofBodyonXAxisofphoneinFrequencyDomain),
                    MeanFrequencyofAccelerationofJerkofBodyonYAxisofphoneinFrequencyDomain=mean(MeanFrequencyofAccelerationofJerkofBodyonYAxisofphoneinFrequencyDomain),
                    MeanFrequencyofAccelerationofJerkofBodyonZAxisofphoneinFrequencyDomain=mean(MeanFrequencyofAccelerationofJerkofBodyonZAxisofphoneinFrequencyDomain),
                    MeanofAngularvelocityofBodyonXAxisofphoneinFrequencyDomain=mean(MeanofAngularvelocityofBodyonXAxisofphoneinFrequencyDomain),
                    MeanofAngularvelocityofBodyonYAxisofphoneinFrequencyDomain=mean(MeanofAngularvelocityofBodyonYAxisofphoneinFrequencyDomain),
                    MeanofAngularvelocityofBodyonZAxisofphoneinFrequencyDomain=mean(MeanofAngularvelocityofBodyonZAxisofphoneinFrequencyDomain),
                    StandardDeviationofAngularvelocityofBodyonXAxisofphoneinFrequencyDomain=mean(StandardDeviationofAngularvelocityofBodyonXAxisofphoneinFrequencyDomain),
                    StandardDeviationofAngularvelocityofBodyonYAxisofphoneinFrequencyDomain=mean(StandardDeviationofAngularvelocityofBodyonYAxisofphoneinFrequencyDomain),
                    StandardDeviationofAngularvelocityofBodyonZAxisofphoneinFrequencyDomain=mean(StandardDeviationofAngularvelocityofBodyonZAxisofphoneinFrequencyDomain),
                    MeanFrequencyofAngularvelocityofBodyonXAxisofphoneinFrequencyDomain=mean(MeanFrequencyofAngularvelocityofBodyonXAxisofphoneinFrequencyDomain),
                    MeanFrequencyofAngularvelocityofBodyonYAxisofphoneinFrequencyDomain=mean(MeanFrequencyofAngularvelocityofBodyonYAxisofphoneinFrequencyDomain),
                    MeanFrequencyofAngularvelocityofBodyonZAxisofphoneinFrequencyDomain=mean(MeanFrequencyofAngularvelocityofBodyonZAxisofphoneinFrequencyDomain),
                    MeanofMagnitudeofAccelerationofBodyinFrequencyDomain=mean(MeanofMagnitudeofAccelerationofBodyinFrequencyDomain),
                    StandardDeviationofMagnitudeofAccelerationofBodyinFrequencyDomain=mean(StandardDeviationofMagnitudeofAccelerationofBodyinFrequencyDomain),
                    MeanFrequencyofMagnitudeofAccelerationofBodyinFrequencyDomain=mean(MeanFrequencyofMagnitudeofAccelerationofBodyinFrequencyDomain),
                    MeanofMagnitudeofAccelerationofJerkofBodyinFrequencyDomain=mean(MeanofMagnitudeofAccelerationofJerkofBodyinFrequencyDomain),
                    StandardDeviationofMagnitudeofAccelerationofJerkofBodyinFrequencyDomain=mean(StandardDeviationofMagnitudeofAccelerationofJerkofBodyinFrequencyDomain),
                    MagnitudeofAccelerationofJerkofBodyinFrequencyDomain=mean(MagnitudeofAccelerationofJerkofBodyinFrequencyDomain),
                    MeanofMagnitudeofAngularvelocityofBodyinFrequencyDomain=mean(MeanofMagnitudeofAngularvelocityofBodyinFrequencyDomain),
                    StandardDeviationofMagnitudeofAngularvelocityofBodyinFrequencyDomain=mean(StandardDeviationofMagnitudeofAngularvelocityofBodyinFrequencyDomain),
                    MeanFrequencyofMagnitudeofAngularvelocityofBodyinFrequencyDomain=mean(MeanFrequencyofMagnitudeofAngularvelocityofBodyinFrequencyDomain),
                    MeanofMagnitudeofAngularvelocityofJerkofBodyinFrequencyDomain=mean(MeanofMagnitudeofAngularvelocityofJerkofBodyinFrequencyDomain),
                    StandardDeviationofMagnitudeofAngularvelocityofJerkofBodyinFrequencyDomain=mean(StandardDeviationofMagnitudeofAngularvelocityofJerkofBodyinFrequencyDomain),
                    MeanFrequencyofMagnitudeofAngularvelocityofJerkofBodyinFrequencyDomain=mean(MeanFrequencyofMagnitudeofAngularvelocityofJerkofBodyinFrequencyDomain))
   
   
   write.table(tidy_data,file="tidy_data.txt",row.name=FALSE)	#Writing final tidy data set to tidy_data in working directory
   
   print("Your Tidy dataset is written in your working Directory. File name is tidy_data")
   
}