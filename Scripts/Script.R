# Script for backing up files
# sources the function file
# and contains use example

# backup_files.r

# source
source("backup_files.R")
# example
backup_files("D:\\Source", "H:\\Backup")


# copy_and_delete.r

# source functions
source("copy_and_delete.R")
# example
source_directory <- "D:\\Source Directory"
target_directory <- "D:\\Target Directory"
copy_any_delete(source_directory, target_directory, output_console = FALSE, output_tree = FALSE, log_file = NULL)