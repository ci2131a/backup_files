#Define function

# main function
backup_files <- function(source_directory, target_directory){
  
  # define start time for duration
  start <- Sys.time()
  
  # run backup function
  backup_actual(sourcedrive = source_directory, targetdrive = target_directory)
  
  # define stop time for duration
  stop <- Sys.time()
  cat("Backup took approximately:", (stop - start)[[1]], "seconds.")
}



backup_actual <- function(sourcedrive, targetdrive){
  
  # define negate
  `%nin%` <- Negate(`%in%`)
  
  # run deletions
  for (dirr in dir(targetdrive)){
    # check if directory in target still exists in source
    print(paste0("Working in ",dirr))
    if((dirr %nin% dir(sourcedrive))){
      # if it does not then delete
      target.sub.path <- paste0(targetdrive, "\\", dirr)
      unlink(target.sub.path, recursive = TRUE)
    }
  } # otherwise move on
  
  
  for (dirr in dir(sourcedrive)){ # look at item in source directory 
    source.sub.path <- paste0(sourcedrive, "\\", dirr) # define path to item in source
    target.sub.path <- paste0(targetdrive, "\\", dirr) # define path to item in target
    print(paste0("Working in ", dirr))
    if (dirr %in% list.dirs(sourcedrive, full.names = FALSE, recursive = FALSE)){ # if item is a directory
      if (dirr %nin% dir(targetdrive)){ # if item in source is not in target
        dir.create(target.sub.path, showWarnings = FALSE) # create the directory
      } # otherwise we assume it is a file in which case we need to copy 
      backup_actual(source.sub.path,target.sub.path) # and rerun the function step for the sub directory
    }# lastly we copy over files that are not in target but in source OR were changed in source
    if(dirr %nin% list.dirs(sourcedrive, full.names = FALSE, recursive = FALSE)){ # if the item is not a directory (ie a file)
      if (dirr %nin% dir(targetdrive)){ # if item in source is not in target{
        file.copy(from = source.sub.path, to = target.sub.path)# note: I still make sure that it is not a directory in my if statement
      }
      if(tools::md5sum(source.sub.path) != tools::md5sum(target.sub.path)){ # and if the item is different in source and target
        file.copy(from = source.sub.path, to = target.sub.path, overwrite = TRUE) # then copy over the source (since it has been updated)
      }
    }
  }
}


