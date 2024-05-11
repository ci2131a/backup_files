library(fs)

# function to create zip backup
create_backup <- function(source_dir, target_file, output_console = FALSE) {
  # Check if source directory exists
  if (!dir_exists(source_dir)) {
    stop("Source directory does not exist")
  }
  
  # Create the zip archive
  zip(target_file, files = dir(source_dir, recursive = TRUE, full.names = TRUE))
  
  cat("Backup created:", target_file, "\n")
}

# Example usage:
source_directory <- "/path/to/source"
target_file <- "backup.zip"
target_directory <- "D:\\Backup Project\\backup.zip"

create_backup(source_directory, target_file)
create_backup(source_directory, target)
