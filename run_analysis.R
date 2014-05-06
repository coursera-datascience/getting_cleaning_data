##########################################################################
## Merge the training and the test sets into one data set.              ##
## Subject ID is merged as the first column of the merged data set.     ##
## Activity type is merged as the second column of the merged data set. ##
##########################################################################
simpleMerge <- function() {
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
                
                subjectID <- read.table(sfName, sep="")
                if (i==1) subFrames <- subjectID
                else subFrames <- rbind(subFrames, subjectID)
        }
        mergedFrames <- cbind(actFrames,mergedFrames)
        mergedFrames <- cbind(subFrames,mergedFrames)
        
        # Export the merged data set
        write.table(mergedFrames, file="simpleMerge.txt", sep=" ", col.name=TRUE, row.names=FALSE)   
        invisible(mergedFrames)
}


#########################################################################
## Label the data set with descriptive variable names.                 ##
## Column headings are copied from the features.txt.                   ##
#########################################################################
desVarMerge <- function(){
        if (!file.exists("simpleMerge.csv")) mergedFrames <- simpleMerge()
        else mergedFrames <- read.table("simpleMerge.txt", sep="")
        
        varNames <- c("subjectID", "activitytype")
        variables <- read.table("./UCI HAR Dataset/features.txt", sep="")
        varNames <- factor(c(as.character(varNames), as.character(variables[,2])))
        colnames(mergedFrames) <- varNames

        # Export the data set containing descriptive labels
        #write.csv(mergedFrames, file="desVarMerge.csv", row.names=FALSE)  
        write.table(mergedFrames, file="desVarMerge.txt", sep=" ", col.names=TRUE, row.names=FALSE)  
        invisible(mergedFrames)
}


#########################################################################
## Replace activity numbers with descriptive activity names.           ##
#########################################################################
desActMerge <- function() {
        if (!file.exists("desVarMerge.csv")) mergedFrames <- desVarMerge()
        else mergedFrames <- read.table("desVarMerge.txt", sep="", header=TRUE, check.names=FALSE)
        
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
        write.table(mergedFrames, file="desActMerge.txt", sep=" ", col.names=TRUE, row.names=FALSE)
        invisible(mergedFrames)
}
        

#########################################################################
## Extracts only the measurments on the mean and standard deviation    ##
## for each measurement.                                               ##
#########################################################################
meanStdMerge <- function(){
        if (!file.exists("desVarMerge.txt")) mergedFrames <- desVarMerge()
        else mergedFrames <- read.table("desVarMerge.txt", sep="", header=TRUE, check.names=FALSE)
        varNames <- colnames(mergedFrames)
        
        meanStdFrames <- mergedFrames[grepl("-mean\\(\\)|std\\(\\)-", varNames)]

        # Export the extracted dataset of means & SDs
        write.table(meanStdFrames, file="meanStdMerge.txt", sep=" ", col.names = TRUE, row.names=FALSE)   
}


#########################################################################
## A new tidy data set with the average of each variable               ##
## for each activity and each subject.                                 ##
#########################################################################
avgMerge <- function(){
        if (!file.exists("desActMerge.csv")) mergedFrames <- desActMerge()
        else mergedFrames <- read.table("desActMerge.txt", sep="", header=TRUE, check.names=FALSE)
        
        avgFrames <- data.frame()
        actLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep="")
        for (id in unique(mergedFrames$subjectID)){ # for each subject
                subjMatched <- mergedFrames[mergedFrames[,"subjectID"]==id,]
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
        colnames(avgFrames) <- colnames(mergedFrames)
        row.names(avgFrames) <- seq(nrow(avgFrames)) 
        
        # Export a second data set containing average values
        write.table(avgFrames, file="avgMerge.txt", sep=" ", col.names = TRUE, row.names=FALSE)  
}