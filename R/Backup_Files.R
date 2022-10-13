#Define function


Backup_Files <- function(sourcedirectory, targetdirectory){
  
  `%nin%` <- Negate(`%in%`)
  sourcedrive <- sourcedirectory
  targetdrive <- targetdirectory
  
  for (dirr in dir(targetdrive)){
    if((dirr %nin% dir(sourcedrive))){
      target.sub.path <- paste0(targetdrive, "\\", dirr)
      unlink(target.sub.path, recursive = TRUE)
    }
  }
  
  
  for (dirr in dir(sourcedrive)){ # look at item in source directory 
    source.sub.path <- paste0(sourcedrive, "\\", dirr) # define path to item in source
    target.sub.path <- paste0(targetdrive, "\\", dirr) # define path to item in target
    if (dirr %in% list.dirs(sourcedrive, full.names = FALSE, recursive = FALSE)){ # if item is a directory
      if (dirr %nin% dir(targetdrive)){ # if item in source is not in target
          dir.create(target.sub.path, showWarnings = FALSE) # create the directory
      } # otherwise we assume it is a file in which case we need to copy 
      backup_files(source.sub.path,target.sub.path) # and rerun the function step for the sub directory
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






