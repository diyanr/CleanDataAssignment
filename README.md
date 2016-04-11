# CleanDataAssignment
Assignment: Getting and Cleaning Data Course Project

Carried out the following steps:
  1.  Create the data directory 
  2.  Download the zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  3.  Unzip the data files
  4.  Load list of features to be used as column names
  5.  Load activity labels to be used for the activity ids
  6.  Load training data
      * Load training subjects
      * Load training activities
      * Merge the training activities with the lables
      * Load training observation
      * Merge all training data
  7.  Load test data
      * Load test subjects
      * Load test activities
      * Merge the test activities with the lables
      * Load test observation
      * Merge all test data
  8.  Merge all training and test data
  9.  Subset all data containing mean and standard deviation
  10. Group by subject and activity and summarize each column mean and write to output
  
