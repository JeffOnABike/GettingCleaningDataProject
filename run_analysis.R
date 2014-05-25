makeTidy <- function() {

        #function only operates on assumption that all files have been downloaded
        #unzipped and stored in the working directory
        
        #read features 
        features <- read.table("features.txt")
        #V2 will be used to name columns of the x_test and y_test data
        
        
        #read test files, apply features names to col names of x_test:
        x_test <- read.table("X_test.txt", comment.char = "", 
                colClasses="numeric", col.names=features$V2)
        y_test <- read.table("y_test.txt", colClasses = "factor", 
                col.names ="activity")
        subject_test <- read.table("subject_test.txt", 
                colClasses = "factor", col.names = "subject")
        
        #read train files, apply features names to col names of y_test:
        x_train <- read.table("X_train.txt", comment.char = "", 
                colClasses="numeric", col.names=features$V2)
        y_train <- read.table("y_train.txt", colClasses = "factor", 
                col.names ="activity")
        subject_train <- read.table("subject_train.txt", 
                colClasses = "factor", col.names = "subject")
        
        #read activity labels
        activity_labels <- read.table("activity_labels.txt")

        ##cbind each test and train dataframes with only columns of interest
        test <- cbind(subject_test, y_test, x_test[grepl("std", names(x_test)) | 
                grepl("mean" , names(x_test))])
        train <- cbind(subject_train, y_train, x_train[grepl("std", names(x_train)) | 
                grepl("mean" , names(x_train))])
        
        #merge test and train vertically with no matches of rows
        merged <- merge(test, train, all=TRUE)
        
        #apply activity labels from activity_labels dataframe
        merged$activity <- factor(merged$activity, levels=1:6, 
                labels=activity_labels$V2)
        
        #merged data now are 10299 independent observations and no NAs
        #> sum(complete.cases(merged))
        #[1] 10299
        #There are 2 columns of IDing variables: subject and activity
        #and there are 79 columns of measured variables
        #> ncol(merged)
        #[1] 81

        #set measureVars to hold all names of measured variables
        measureVars <- names(merged[3:81])
        
        #expand merged based separating out all combos of subject and activity
        mergedMelt <- melt(merged, id=c("subject", "activity"), measure.vars = measureVars)
        #now have 823920 or 813612???? observations
        
        #cast back as subject, activity, variable means
        mergedCast <- dcast(mergedMelt, subject + activity ~ variable, mean)
        
        #assign order of levels for subjects as 1:30
        mergedCast$subject <- factor(mergedCast$subject, levels= 1:30)
        
        #tidy data is arranged by subject then activity:
        tidyData <- arrange(mergedCast, subject, activity)
        
        #resulting dataframe is 180 observations (means) of 79 measured variables.  
}        