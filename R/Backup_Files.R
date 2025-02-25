# Define negate operator
`%nin%` <- Negate(`%in%`)

# Logging function
log_message <- function(message, level = "INFO") {
  cat(sprintf("[%s] %s: %s\n", Sys.time(), level, message))
}

# Main function to perform the backup
backup_files <- function(source_directory, target_directory, print_output = TRUE) {
  # Measure the time taken for the backup process
  elapsed_time <- system.time({
    if (print_output){
      log_message("Starting backup...")
    }
    backup_actual(source_directory, target_directory, print_output)
  })
  if (print_output){
    log_message(sprintf("Backup took approximately: %.2f seconds.", elapsed_time[["elapsed"]]))
  }
}

# Helper function to perform the actual backup
backup_actual <- function(source_directory, target_directory, print_output) {
  # Run deletions for directories not present in source
  handle_deletions(source_directory, target_directory, print_output)
  
  # Iterate over items in source directory
  for (item in dir(source_directory)) {
    source_sub_path <- file.path(source_directory, item)
    target_sub_path <- file.path(target_directory, item)
    
    # print status message of working directory if enabled
    if (print_output){
      log_message(sprintf("Working in %s", item))
    }
    
    if (dir.exists(source_sub_path)) {
      if (!dir.exists(target_sub_path)) {
        # create directory in target that is in source if it does not exist in target
        dir.create(target_sub_path, showWarnings = FALSE)
      }
      # recursively run the function to perform previous operations on current directories
      backup_actual(source_sub_path, target_sub_path, print_output)
    } else {
      handle_file_copy(source_sub_path, target_sub_path, print_output)
    }
  }
}

# Function to handle deletions
handle_deletions <- function(source_directory, target_directory, print_output) {
  for (dir_name in dir(target_directory)) {
    if (dir_name %nin% dir(source_directory)) {
      target_sub_path <- file.path(target_directory, dir_name)
      if (print_output){
        log_message(sprintf("Deleting %s", target_sub_path), level = "WARN")
      }
      tryCatch({
        unlink(target_sub_path, recursive = TRUE)
      }, error = function(e) {
        log_message(sprintf("Failed to delete %s: %s", target_sub_path, e$message), level = "ERROR")
      })
    }
  }
}

# Function to handle file copy
handle_file_copy <- function(source_sub_path, target_sub_path, print_output) {
  if (!file.exists(target_sub_path) || tools::md5sum(source_sub_path) != tools::md5sum(target_sub_path)) {
    if (print_output){
      log_message(sprintf("Copying file from %s to %s", source_sub_path, target_sub_path))
    }
    tryCatch({
      file.copy(from = source_sub_path, to = target_sub_path, overwrite = TRUE)
    }, error = function(e) {
      log_message(sprintf("Failed to copy file from %s to %s: %s", source_sub_path, target_sub_path, e$message), level = "ERROR")
    })
  }
}

# Example usage
# backup_files("path/to/source_directory", "path/to/target_directory")
#backup_files("D:\\Backup Project\\Test\\Source", "D:\\Backup Project\\Test\\Backup", print_output = F)
