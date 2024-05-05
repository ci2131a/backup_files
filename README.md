# backup_files


The goal of this program is to ensure an extra copy of data is stored in another location. This is done through the `Backup_Files` function which takes one directory to be the source and another to be the target and iteratively updates files in the target directory such that they match the source directory. This program has been helpful to backup the large quantities of video files from video game clips that are created, deleted, and reorganized over time. 

The program was originally written in Python with some assistance from JT who showed me to improve the program using recursive functions and how to make shell scripts to execute the program. Subsequently, I translated our program to R as a personal exercise. 

## Repository Organization

### Python

The original program exists in the following file:

* `backup_files.py`

It defines the function and executes the backup process while also tracking the approximate time to completion.

In order to use, edit the file and change the source and target variable file paths. Then execute the entire file by running this Python file or executing either shell script (see the Shell section for details).

### R

* `Backup_Files.r`
* `Script.r`

The `Backup_Files.r` file defines the function which is used in `Script.r` to change files. Edit the `Script.r` file with 

### Shell

Contains two shell scripts to run the Python program in either PowerShell or GitBash. To use, edit the files in a text editor such as Notepad and modify the file path to the location of the Python file.


## Version History

See `NEWS.md` for version history.



