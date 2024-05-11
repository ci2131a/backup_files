#
# Main Script for Python Files

# backup_files
#
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

sourcedrive = 'P:\\Source'
targetdrive = 'H:\\Folder\\Target'

import time
from shutil import rmtree, copyfile
from os import listdir, remove, mkdir
from os.path import isdir, isfile
from filecmp import cmp

import backup_files.py

# start time
start_time = time.time()
# backup_files()
backup_files(sourcedrive,targetdrive)
# for timing
print("--- %s seconds ---" % (time.time() - start_time))
