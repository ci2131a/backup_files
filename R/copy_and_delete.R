library(fs)


copy_and_delete <- function(source_dir, target_dir, output_console = FALSE, output_tree = FALSE, log_file = NULL) {
  
  # Check if source directory exists
  if (!dir_exists(source_dir)) {
    stop("Source directory does not exist")
  }
  
  # Ensure target directory exists
  if (!dir_exists(target_dir)) {
    dir_create(target_dir)
  }
  
  # Output tree structure if you want (source and target)
  if(output_tree){
    dir_tree(source_dir, recurse = TRUE)
    dir_tree(target_dir, recurse = TRUE)
  }
  
  # Function to check if the files are equal based on their size in bytes
  file_cmp <- function(path1, path2){
    file_size(path1)[[1]] == file_size(path2)[[1]]
  }
  
  # define start time to measure backup duration
  start <- Sys.time()

  # Copy files from source to target directory (including subdirectories)
  for (path in dir_ls(source_dir, recurse = TRUE)) {
    target_path <- path(target_dir, path_rel(path, source_dir))
    
    if(!file_exists(target_path) || !file_cmp(path, target_path)) {
      
      # Create directories in the target if it's a directory
      if(is_dir(path)) {
        dir_create(target_path, recurse = TRUE)
        if(output_console){
          cat("Created directory:", target_path, "\n")
        }
        if(!is.null(log_file)){
          write(paste("Created directory:", target_path, "\n"), file = log_file, append = TRUE)
        }
      } else{ # Otherwise, treat as a file and copy file
        file_copy(path, target_path, overwrite = TRUE)
        if(output_console){
          cat("Copied:", path, "->", target_path, "\n")
        }
        if(!is.null(log_file)) {
          write(paste("Copied:", path, "->", target_path), file = log_file, append = TRUE)
        }
      }
    }
  }
  
  # Delete extra files in the target directory (including subdirectories)
  for(path in dir_ls(target_dir, recurse = TRUE)) {
    source_path <- path(source_dir, path_rel(path, target_dir))
    
    if(!file_exists(source_path)) {
      if(is_dir(path)) {
        dir_delete(path)
      } else {
        file_delete(path)
      }
      if(output_console){
        cat("Deleted:", path, "\n") 
      }
      if(!is.null(log_file)) {
        write(paste("Deleted:", path), file = log_file, append = TRUE)
      }
    }
  }
  
  # define stop time for duration
  stop <- Sys.time()
  if(output_console){
    cat("Backup took approximately:", (stop - start)[[1]], "seconds.")
  }
  
}

# Example usage:
source_directory <- "D:\\Source Directory"
target_directory <- "D:\\Target Directory"


copy_and_delete(source_directory, target_directory, output_console = TRUE, output_tree = FALSE, log_file = "mylog.txt")

