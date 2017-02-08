## Verifies that the required libraries get installed if needed
verify_dependencies <- function(...) {
  lapply(list(...), function(lib) {
    if (!lib %in% installed.packages()) 
      install.packages(lib)
  })
}

## Verify dependencies and load
verify_dependencies("dplyr", "reshape2")
library("dplyr")
library("reshape2")

main_data_directory <- "UCI HAR Dataset"

load_file <- function(filename, ...) {
  file.path(..., filename) %>%
    read.table(header = FALSE)
}

load_train_file <- function(filename) {
  load_file(filename, main_data_directory, "train")
}

load_test_file <- function(filename) {
  load_file(filename, main_data_directory, "test")
}

## Uses list of activity values to describe test / training labels
## Params: ds .. label dataset
## Returns: the original dataset with human readable column name and values
describe_lbl_ds <- function(ds) {
  names(ds) <- activity_col  
  ds$Activity <- factor(ds$Activity, levels = activity_lbl$V1, labels = activity_lbl$V2)
  ds
}

## Takes a dataset capturing results of feature tests and associates columns with individual features
## Params: ds .. activity dataset
## Returns: the original dataset with columns indicating which feature it describes
describe_act_ds <- function(ds) {
  col_names <- gsub("-", "_", features$V2)
  col_names <- gsub("[^a-zA-Z\\d_]", "", col_names)
  names(ds) <- make.names(names = col_names, unique = TRUE, allow_ = TRUE)
  ds
}

## Adjusts column name in the data set identifying test participants
describe_sub_ds <- function(ds) {
  names(ds) <- subject_col
  ds
}

## Download and extract a zip file with datasets
if (!file.exists(main_data_directory)) {
  source_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  dest_file <- "Dataset.zip"
  download.file(source_url, destfile = dest_file, method = "curl")
  unzip(dest_file)
  if (!file.exists(main_data_directory)) 
    stop("The downloaded dataset doesn't have the expected structure!")
}

subject_col <- "Subject"
activity_col <- "Activity"

features <- load_file("features.txt", main_data_directory)
activity_lbl <- load_file("activity_labels.txt", main_data_directory)

train_set <- load_train_file("X_train.txt") %>% describe_act_ds
train_lbl <- load_train_file("y_train.txt") %>% describe_lbl_ds
train_sub <- load_train_file("subject_train.txt") %>% describe_sub_ds

test_set <- load_test_file("X_test.txt") %>% describe_act_ds
test_lbl <- load_test_file("y_test.txt") %>% describe_lbl_ds
test_sub <- load_test_file("subject_test.txt") %>% describe_sub_ds

## Merge the training and the test sets to create one dataset
## Extract only the measurements on the mean and standard deviation for each measurement
merge_data <- rbind(
  cbind(train_set, train_lbl, train_sub),
  cbind(test_set, test_lbl, test_sub)
) %>%
  select(
    matches("mean|std"), 
    one_of(subject_col, activity_col)
  )

## Create a second, independent tidy data set with the average of each variable for each activity and each subject
id_cols <- c(subject_col, activity_col)
tidy_data <- melt(
  merge_data, 
  id = id_cols, 
  measure.vars = setdiff(colnames(merge_data), id_cols)
) %>%
  dcast(Subject + Activity ~ variable, mean)

write.table(tidy_data, file = "tidy_data.txt", sep = ",", row.names = FALSE)
