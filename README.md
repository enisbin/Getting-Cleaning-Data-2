# Getting-Cleaning-Data-2
Getting and Cleaning Data course project. A R script called run_analysis.R has been prepared. This script does the following:

1. It checks if the dataset exists in the working directory and if not, it downloads the dataset from a URL specified.
2. It loads information about the activities and features from the dataset.
3. It first loads the training and test datasets and then retains only those those columns which contain mean or standard deviation.
4. It then loads data related to the activity and subject for each dataset and then merges those columns.
5. It finally merges the two datasets
6. It finally creates a dataset in a file called "tidy.txt" that consists cleansed data of the mean value of each variable for each subject and activity pair.
