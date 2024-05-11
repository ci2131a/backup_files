# Python script to define function 
# for copying directory structure
# from a source directory to a 
# target directory.
# JT made this possible

#import time
#from shutil import rmtree, copyfile
#from os import listdir, remove, mkdir
#from os.path import isdir, isfile
#from filecmp import cmp

def backup_files(source, target):
  
  dirsource = set(listdir(source))
  dirtarget = set(listdir(target))
  
  for dirr in dirtarget:
    if dirr not in dirsource:
      sourcepath = target + "\\" + dirr
      try: 
        rmtree(sourcepath)
      try:
        remove(sourcepath)
      except OSError as e:
        print("Could not remove:", sourcepath)
        
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
      elif not cmp(sourcepath, targetpath, shallow = False):
        copyfile(sourcepath, targetpath)
        


