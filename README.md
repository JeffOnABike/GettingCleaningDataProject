# README for run_analysis.R

##makeTidy() function opens relevant files and makes tidyData
*given that they are unzipped and saved in the working directory

makeTidy reads the following unzipped text files:

features
*X_test
*y_test
*subject_test
*X_train
*y_train
*subject_train
*activity_labels

##descriptions of read files:

*features are the column labels for X_test and X_train

*X_test and Y_test are a series of measurements based on features of the accelerometer in the smartphones of the subjects

*subject_test and subject_train are the subject (1-30) identifiers for the matching rows of measured variables in X_test and X_train

*x_train and y_train are the identified activity codes (1-6) 

*activity_labels are the activity names for each of the activity codes

##Script description

the function column binds the data for matching observations in both the test and train experiments into their respective datasets "test" and "train".  

the test and train dataframes are subset on column names corresponding to standard deviation and mean measurements of the features.

merged is a dataframe which simply appends all the observations of train to test, creating 10299 independent observations and has the appropriate activity labels 

tidyData is the melted and recast form of merged that summarizes the means of the measured variables of interest.