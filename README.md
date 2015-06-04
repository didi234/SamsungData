# SamsungData
Dataset for the assignment: "Getting and cleaning data"  
This dataset includes the following files:  
* README.md  
* codebook.md  
* run_analysis.R  
* tidy.data.txt

##README.md 
The file you are reading

##codebook.md 
Codebook describing *tidy.data.txt*

##run_analysis.R  
R-code to create the tidy data subset (*tidy.data.txt*) in following steps:  
* Read train and test datafiles into R using *read.table* (data, activity label and subject files)
* Combine test data with activity labels and subjects using *cbind*
* Combine train data with activity labels and subjects using *cbind*
* Merge train and test data using *rbind*
* Read files with activity label description and features into R using *read.table*
* Label column headers using data from features using *names*
* Assign activity label desriptions to each row using *merge*
* Extract only the measurements on the mean and standard deviation for each measuremen by selecting columns containing mean() or std() in header using *grep*
* Create second tidy data set with the average of each variable for each activity and each subject using *aggregate*
* Write data to txt file using *write.table*  

**IMPORTANT: To run the code, the "UCI HAR Dataset" folder must be in your working directory**  

##tidy.data.txt
Tidy data set as requested in point 5 following the tidy data principles:  
* Each variable is in one column  
* Each different observation of that variable in a different row  

For further description of tidy.data.txt please refer to codebook.md
To read *tidy.data.txt* into R please use the following code in order to preserve column names with brackets:  
**data <- read.table("tidy.data.txt", header = T, check.names = F)**

