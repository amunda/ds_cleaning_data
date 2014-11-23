library(plyr)

run_analysis <- function() {

  activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt')
  
  #Fetching both the datasets with their Activity and Subject Ids
  test_dataset <- get_test_dataset(activity_labels)
  train_dataset <- get_train_dataset(activity_labels)
  
  
  # Merging two sets
  merged_set  <- rbind(test_dataset, train_dataset)
  
  # Filtering by columns
  col_filtered_set <- select(merged_set, c(contains('.mean.'), contains('.std.'), contains('Activity'), contains('Subject')))
  
  final_dataset <- data.table(col_filtered_set)
  final_dataset <- final_dataset[,lapply(.SD, mean), by = list(Activity,Subject)]
  final_dataset
}


#features     <- read.table('UCI HAR Dataset/features.txt')
#training_set <- read.table('UCI HAR Dataset/train/X_train.txt')
#test_set     <- read.table('UCI HAR Dataset/test/X_test.txt')

#training_labels <- join(activity_labels, read.table('UCI HAR Dataset/train/y_train.txt'))
#test_labels     <- join(activity_labels, read.table('UCI HAR Dataset/train/y_train.txt'))




get_test_dataset <- function(activity_labels) {
  
  test_set     <- read.table('UCI HAR Dataset/test/X_test.txt')
  colnames(test_set) <- make.names(read.table('UCI HAR Dataset/features.txt')$V2, unique=TRUE)
  
  test_labels  <- join(read.table('UCI HAR Dataset/test/y_test.txt'), activity_labels)$V2
  subjects     <- read.table('UCI HAR Dataset/test/subject_test.txt')
  
  cbind(test_set, Activity=test_labels, Subject=subjects$V1)
  
}

get_train_dataset <- function(activity_labels) {
  
  train_set           <- read.table('UCI HAR Dataset/train/X_train.txt')
  colnames(train_set) <- make.names(read.table('UCI HAR Dataset/features.txt')$V2, unique=TRUE)
  
  train_labels        <- join(read.table('UCI HAR Dataset/train/y_train.txt'), activity_labels)$V2
  subjects            <- read.table('UCI HAR Dataset/train/subject_train.txt')
  
  cbind(train_set, Activity=train_labels, Subject=subjects$V1)
}


  #training_set <- strsplit(readLines("UCI HAR Dataset/train/X_train.txt"), "[[:space:]]+")
 
  
  #activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt')
  #training_labels <- join(activity_labels, read.table('UCI HAR Dataset/train/y_train.txt'))
  #test_labels <- join(activity_labels, read.table('UCI HAR Dataset/train/y_train.txt'))
  
  
  #training_subjects <- read.table('UCI HAR Dataset/train/subject_train.txt')
  #joined <- join_all(list(training_labels, activity_labels, training_subjects))
#}
