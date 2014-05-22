run_analysis  <- function ( ) {
    ## Make sure you load the data.table package  
    ## Set your working directory to be in the UCI HAR Dataset
    
    ## Merge the training and the test sets to create one data set.
    trainSet <- data.table(read.table("train/X_train.txt"))
    testSet <- data.table(read.table("test/X_test.txt"))
    combinedSet <- rbind(trainSet,testSet)
    
    ## Create and combine data tables for the subject numbers
    subjectNumsTrain <- read.table("train/subject_train.txt")
    subjectNumsTest <- read.table("test/subject_test.txt")
    combinedSubjectNums <-rbind(subjectNumsTrain,subjectNumsTest)
    
    ## Create data table for features
    features <- read.table("features.txt", stringsAsFactors=F)
    
    ## Change column names to the feature names
    colnames(combinedSet) <- features[,2]
    
    ## Add subject numbers to data
    combinedSetWithSubNums <- combinedSet[,Subjects:= data.table(combinedSubjectNums)]
   
    ## Extract the mean and standard deviation for each measurement. 
    ##  Create null vectors so they are accessible outside the scope of the loop
    means <- c()
    standardDev <- c()
    
    ##  Loop through all columns except 563 (which contains subject numbers)
    for(i in 1:562){
        means[i] <- mean(combinedSet[[i]])
        standardDev[i] <- sd(combinedSet[[i]])
    }
    ##  Create a matrix of the mean and sd
    meanAndStandardDev <- cbind(means,standardDev)
    write.table(meanAndStandardDev, file="meanAndStandardDev.csv",sep=",",col.names=NA,qmethod="double")
    
    ##   Create two vectors from the numerically coded activities.
    activitiesTrain <- read.table("train/y_train.txt")
    activitiesTest <- read.table("test/y_test.txt")
    
    ##  Then rbind the two vectors together.
    activitiesCombined <- rbind(activitiesTrain,activitiesTest)
    
    ##  Convert the numerical codes to activity labels
    activitiesLabel <- c()
    
    for (i in 1:length(activitiesCombined[,1])) {
        if (activitiesCombined[i,] == 1) {
            activity <- "Walking"
        } else if (activitiesCombined[i,] == 2) {
            activity <- "Walking Upstairs"
        } else if (activitiesCombined[i,] == 3) {
            activity <- "Walking Downstairs"
        } else if (activitiesCombined[i,] == 4) {
            activity <- "Sitting"
        } else if (activitiesCombined[i,] == 5) {
            activity <- "Standing"
        } else {
            activity <- "Laying"
        }      
        ## Append that item to activitiesLabel
        activitiesLabel <- append(activitiesLabel,activity)
    }
   
    ## Add the labels to the combined data set
    combinedSetWithActLabels <- cbind(combinedSetWithSubNums, activitiesLabel)
  
    ##  Create a second, independent tidy data set with the average of each variable for 
    ##  each activity and each subject. 
    ##  The tidy data set should be 180 rows (30 subjects by 6 activities) 
    ##  by 565 columns (561 variables plus subject number and activity label  plus the
    ##  2 group columns added by the aggregate function
    attach(combinedSetWithActLabels)
    tidyDataSet <- aggregate(combinedSetWithActLabels, by=list(Subjects,activitiesLabel), FUN=mean, na.rm=TRUE)
    write.table(tidyDataSet, file="tidyDataSet.csv",sep=",",col.names=NA,qmethod="double")
}
