# Python script to define function 
# for copying directory structure
# from a source directory to a 
# target directory.
# JT made this possible

# Modify the following uncommented
# absolute paths so that they 
# match your desired source and
# target directories similar to
#
# sourcedrive = 'D:\\Source Folder'
# targetdrive = 'H:\\Target Folder'
#
# Be sure to include \\ between each subdirectory
# as Python requires this convention.

sourcedrive = 'D:\\Projects\\Backup Project\\Copy Script Backup Test Directory'
targetdrive = 'D:\\Projects\\Backup Project\\Copy Script Test Directory'

import time
start_time = time.time()
from shutil import rmtree, copyfile
from os import listdir, remove, mkdir
from os.path import isdir, isfile

def backup_files(source, target):
  
  dirsource = set(listdir(source))
  dirtarget = set(listdir(target))
  
  for dirr in dirtarget:
    if dirr not in dirsource:
      sourcepath = target + "\\" + dirr
      try: 
        rmtree(sourcepath)
      except OSError as e:
        remove(sourcepath)
        
  for dirr in dirsource:
    sourcepath = source + "\\" + dirr
    targetpath = target + "\\" + dirr
    if isdir(sourcepath):
      if dirr not in dirtarget:
        mkdir(targetpath)
      backup_files(sourcepath, targetpath)
    else:
      if dirr not in dirtarget:
        copyfile(sourcepath, targetpath)
        
  
backup_files(sourcedrive,targetdrive)

print("--- %s seconds ---" % (time.time() - start_time))
