run_analysis <- function() {
  library(dplyr)
  ## Create the data directory 
  if (!file.exists("data")){
    dir.create("data")
  }
  
  ## Download the zip file
  if (!file.exists("./data/Dataset.zip")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, "./data/Dataset.zip")
  }
  
  ## Unzip the data files
  if (!file.exists("UCI HAR Dataset")){
    unzip("./data/Dataset.zip")
  }
  
  ## Load features
  features <- read.table("./UCI HAR Dataset/features.txt")
  featureNames <- features[,2]
  
  ## Load activity labels
  actLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
  names(actLabels) <- c("activity_id","activity_label")
  
  ## Load training subjects
  trainSub <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  names(trainSub) <- "subject_id"
  
  ## Load training activities
  trainAct <- read.table("./UCI HAR Dataset/train/y_train.txt")
  names(trainAct) <- "activity_id"
  
  # Merge the training activities with the lables
  trainActLabels <- merge(trainAct, actLabels, by = "activity_id")
  
  # Load training observation
  trainObs <- read.table("./UCI HAR Dataset/train/X_train.txt")
  names(trainObs) <- featureNames
  
  # Merge all training data
  trainingData <- cbind(data.frame(data_type=rep("TRAIN",times=nrow(trainSub))), trainSub, trainActLabels, trainObs)

  ## Load test subjects
  testSub <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  names(testSub) <- "subject_id"
  
  ## Load test activities
  testAct <- read.table("./UCI HAR Dataset/test/y_test.txt")
  names(testAct) <- "activity_id"
  
  # Merge the test activities with the lables
  testActLabels <- merge(testAct, actLabels, by = "activity_id")
  
  # Load test observation
  testObs <- read.table("./UCI HAR Dataset/test/X_test.txt")
  names(testObs) <- featureNames
  
  # Merge all test data
  testData <- cbind(data.frame(data_type=rep("TEST",times=nrow(testSub))), testSub, testActLabels, testObs)
  
  # Merge all data
  allData <- rbind(trainingData, testData)

  # Subset of data containing mean and standard deviation
  subCols <- grep("subject_id|activity_label|mean|std", names(allData))
  subData <- allData[, subCols]

  # Group by subject and activity and summarize each column
  grpData <- group_by(subData, subject_id, activity_label) %>% summarise_each(funs(mean))
  write.table(grpData, "grpData.txt", row.names = FALSE)
  
}
