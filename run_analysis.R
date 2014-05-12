##########################################################################
## Merge the training and the test sets into one data set.              ##
## Subject ID is merged as the first column of the merged data set.     ##
## Activity type is merged as the second column of the merged data set. ##
##########################################################################
SimpleMerge <- function() {
        # sub-directory and file names
        subDir <- c("test", "train")
        activityFName <- "y_"
        dataFName <- "X_"
        subjectFName <- "subject_"
        
        dirNames <- vector()
        mergedFrames <- data.frame()
        subFrames <- data.frame()       
        
        # Retrieve directory names
        for (i in 1:length(subDir)){
                dirNames <- append(dirNames, paste("./UCI HAR Dataset/", subDir[i], "/", sep=""))
        }
        
        # Merge data sets as well as subject IDs and activity types
        for (i in 1:length(subDir)){
                dfName <- paste(dirNames[i], dataFName, subDir[i], ".txt", sep="")
                afName <- paste(dirNames[i], activityFName, subDir[i], ".txt", sep="")
                sfName <- paste(dirNames[i], subjectFName, subDir[i], ".txt", sep="")
                
                data <- read.table(dfName, sep="")
                if (i==1) mergedFrames <- data
                else mergedFrames <- rbind(mergedFrames, data)

                activity <- read.table(afName, sep="")
                if (i==1) actFrames <- activity
                else actFrames <- rbind(actFrames, activity)
                
                subjectid <- read.table(sfName, sep="")
                if (i==1) subFrames <- subjectid
                else subFrames <- rbind(subFrames, subjectid)
        }
        mergedFrames <- cbind(actFrames,mergedFrames)
        mergedFrames <- cbind(subFrames,mergedFrames)
        
        # Assign original variable names
        varNames <- c("subjectid", "activitytype")
        variables <- read.table("./UCI HAR Dataset/features.txt", sep="")
        varNames <- factor(c(as.character(varNames), as.character(variables[,2])))
        colnames(mergedFrames) <- varNames
        
        # Export the merged data set
        write.table(mergedFrames, file="SimpleMerge.txt", sep=" ", col.name=TRUE, row.names=FALSE)   
        invisible(mergedFrames)
}


#########################################################################
## Extracts only the measurments on the mean and standard deviation    ##
## for each measurement.                                               ##
#########################################################################
MeanStdMerge <- function(){
        if (!file.exists("SimpleMerge.txt")) mergedFrames <- SimpleMerge()
        else mergedFrames <- read.table("SimpleMerge.txt", sep="", header=TRUE, check.names=FALSE)
        varNames <- colnames(mergedFrames)
        
        mergedFrames <- mergedFrames[grepl("subjectid|activitytype|-mean\\(\\)|-std\\(\\)", varNames)]
        
        # Export the extracted dataset of means & SDs
        write.table(mergedFrames, file="MeanStdMerge.txt", sep=" ", col.names = TRUE, row.names=FALSE)  
        invisible(mergedFrames)
}

#########################################################################
## Label the data set with descriptive variable names.                 ##
## Column headings are copied from the features.txt.                   ##
#########################################################################
DesVarMerge <- function(){
        if (!file.exists("MeanStdMerge.txt")) mergedFrames <- MeanStdMerge()
        else mergedFrames <- read.table("MeanStdMerge.txt", sep="", header=TRUE, check.names=FALSE)
        
        varNames <- colnames(mergedFrames)
        
        # Update variable names without special characters
        varNames <- gsub("^t", "time", varNames)
        varNames <- gsub("^f", "frequency", varNames)
        varNames <- gsub("Acc", "acceleration", varNames)
        varNames <- gsub("Gyro", "gyroscope", varNames)
        varNames <- gsub("Mag", "magnitude", varNames)
        varNames <- gsub("-std", "\\.standarddeviation", varNames)
        
        # For future - If need to extract different variables, variable names can be updated using this code chuck
        # varNames <- gsub("-sma", "\\.signalmagnitudearea", varNames)
        # varNames <- gsub("-iqr", "\\.interquartilerange", varNames)
        # varNames <- gsub("-arCoeff", "\\.autoregressioncoefficient", varNames)
        # varNames <- gsub("-mad", "\\.medianabsolutedeviation", varNames)
        # varNames <- gsub("-max", "\\.maximum", varNames)
        # varnames <- gsub("-min", "\\.minimum", varNames)
        # varNames <- gsub("-maxInds", "\\.largestmagnitudeindex", varNames)
        # varNames <- gsub("-meanFreq", "\\.weightedaveragefrequency", varnames)
        
        varnames <- gsub("-[X|Y|Z]", "\\.[x|y|z]", varNames)
        varNames <- gsub("-", "\\.", varNames)
        varNames <- gsub("\\(\\)", "", varNames)
        varNames <- gsub(",", "\\.", varNames)
        varNames <- tolower(varNames)
        
        colnames(mergedFrames) <- varNames

        # Export the data set containing descriptive labels
        write.table(mergedFrames, file="DesVarMerge.txt", sep=" ", col.names=TRUE, row.names=FALSE)  
        invisible(mergedFrames)
}


#########################################################################
## Replace activity numbers with descriptive activity names.           ##
#########################################################################
DesActMerge <- function() {
        if (!file.exists("DesVarMerge.txt")) mergedFrames <- DesVarMerge()
        else mergedFrames <- read.table("DesVarMerge.txt", sep="", header=TRUE, check.names=FALSE)
        
        actLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep="")
        activityDes <- vector()
        for (i in 1:nrow(mergedFrames)){
                for (j in 1:nrow(actLabels)){
                        if (mergedFrames[i,2]== actLabels[j,1]){ 
                                activityDes <- factor(c(as.character(activityDes), as.character(actLabels[j,2])))
                                break
                        }
                }
        }
        mergedFrames[, "activitytype"] <- activityDes
        
        # Export the dataset containing descriptive activity names
        write.table(mergedFrames, file="DesActMerge.txt", sep=" ", col.names=TRUE, row.names=FALSE)
        invisible(mergedFrames)
}
        

#########################################################################
## A new tidy data set with the average of each variable               ##
## for each activity and each subject.                                 ##
#########################################################################
AvgMerge <- function(){
        if (!file.exists("DesActMerge.txt")) mergedFrames <- DesActMerge()
        else mergedFrames <- read.table("DesActMerge.txt", sep="", header=TRUE, check.names=FALSE)
        
        avgFrames <- data.frame()
        actLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep="")
        for (id in unique(mergedFrames$subjectid)){ # for each subject
                subjMatched <- mergedFrames[mergedFrames[,"subjectid"]==id,]
                for (type in unique(actLabels[,2])){  # for each activity type
                        actMatched <- subjMatched[subjMatched[,"activitytype"]==type,]
                        if (nrow(actMatched)>0){
                                means <- vector()
                                for (var in 3:length(actMatched)){
                                        means <- append(means, mean(actMatched[,var]))
                                }
                                
                                df <- t(as.data.frame(c(id, type, means)))
                                avgFrames <- rbind(avgFrames, as.data.frame(df))
                        }
                }
        }
        varNames <- colnames(mergedFrames)
        varNames <- gsub("^time", "average\\.time", varNames)
        varNames <- gsub("^frequency", "average\\.frequency", varNames)
        colnames(avgFrames) <- varNames
        row.names(avgFrames) <- seq(nrow(avgFrames)) 
        
        # Export a second data set containing average values
        write.table(avgFrames, file="AvgMerge.txt", sep=" ", col.names = TRUE, row.names=FALSE)  
}