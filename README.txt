The R script run_analysis.R is for the course project on Getting and Cleaning Data. Below is an explnation of what the script does step by step. 

1. Load the package reshape2 for reshaping data.
2. Download the zipped dataset if it does not exit in the working directory.
3. Unzip the dataset if the data directory does not exit.
4. Load the data in the train and test datasets, which are stored in the ./train and ./test subdirectoies, respectively. Each data set contains the subject ID, the measurement values, and the activity ID.
5. Load the names of measured variables, which is stored in features.txt, and the ID and the names of activities, which are stored in activity_labels.txt.
6. Rename the columns of the read-in information on activity ID and names
7. Merge the train and test datasets
8. Renme the columns of the merged dataset. The 1st and the last columns are the subject ID and activity ID, respectively. Other columns are values of different measured variables. 
9. Extract only the measurements on the mean and standard deviation for each measurement. 
10. Replace activity ID with descriptive name. 
11. Make column names readable. 
12. Create a second, independnt tidy data set with the average of each variable for each activity and each subject.
13. Write out the tidy data set to all_data_tidy.txt. 
