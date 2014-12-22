#read in the test data
test.x <- read.table("X_test.txt")
test.y <- read.table("y_test.txt")
test.sub <- read.table("subject_test.txt")

#read in the train data
train.x <- read.table("X_train.txt")
train.y <- read.table("y_train.txt")
train.sub <- read.table("subject_train.txt")

#read in features
feat <- read.table("features.txt")
colnames(test.x) <- feat[,2]
colnames(train.x) <- feat[,2]

#add activity labels to test data
for(i in 1:2947){
  if(test.y[i,1]==1){
    test.y[i,1] <- "WALKING"
  }
  if(test.y[i,1]==2){
    test.y[i,1] <- "WALKING_UPSTAIRS"
  }
  if(test.y[i,1]==3){
    test.y[i,1] <- "WALKING_DOWNSTAIRS"
  }
  if(test.y[i,1]==4){
    test.y[i,1] <- "SITTING"
  }
  if(test.y[i,1]==5){
    test.y[i,1] <- "STANDING"
  }
  if(test.y[i,1]==6){
    test.y[i,1] <- "LAYING"
  }
}

#add activity labels to train data
for(i in 1:7352){
  if(train.y[i,1]==1){
    train.y[i,1] <- "WALKING"
  }
  if(train.y[i,1]==2){
    train.y[i,1] <- "WALKING_UPSTAIRS"
  }
  if(train.y[i,1]==3){
    train.y[i,1] <- "WALKING_DOWNSTAIRS"
  }
  if(train.y[i,1]==4){
    train.y[i,1] <- "SITTING"
  }
  if(train.y[i,1]==5){
    train.y[i,1] <- "STANDING"
  }
  if(train.y[i,1]==6){
    train.y[i,1] <- "LAYING"
  }
}

test.mrg <- cbind(test.x,test.y,test.sub) #merge test tables
train.mrg <- cbind(train.x,train.y,train.sub) #merge train tables
data <- rbind(test.mrg,train.mrg) #merge test and train data into one set

#extract mean and std data
extract <- 1:10299 #initialize extract array
for(i in 1:561){
  if(grepl("mean",feat[i,2])==TRUE | grepl("std",feat[i,2])==TRUE){
    extract <- cbind(extract,data[,i])
  }
}
extract <- extract[,-1] #remove "dummy" 1st column
xtrct <- cbind(extract,data[,562],data[,563]) #add back in "activities" and "person" columns
colnames(xtrct)[81] <- "Activity"; colnames(xtrct)[82] <- "Person"

#tidy data set
spl.act <- split(xtrct,xtrct$Individual) #split data by activity
spl.person <- split(xtrct,xtrct$Person) # split data by person

avg.act <- colmeans(spl.act) #average each column by activity
avg.person <- colmeans(spl.person) #average each column by person

tidy <- rbind(avg.act,avg.person)
write.table(tidy,file = "tidy.txt",row.name=FALSE) #save output to file

