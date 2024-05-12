# backup_files


The goal of this program is to ensure an extra copy of data is stored in another location. This is done through the `backup_files` function which takes one directory to be the source and another to be the target and iteratively updates files in the target directory such that they match the source directory. This program has been helpful to backup the large quantities of video files from video game clips that are created, deleted, and reorganized over time. 

The program was originally written in Python with some assistance from JT who showed me to improve the program using recursive functions and how to make shell scripts to execute the program. Subsequently, I translated our program to R as a personal exercise. I also used this project as an exercise for programming with AI. In that regard, some functions were entirely developed by ChatGPT and some drew inspiration from code or packages that were suggested through talking with the AI about what this project is. 

## Repository Organization

### Python

Some Python code for creating backups:

* `backup_files.py` - original project file developed with assistance from JT. Using recursive functions to iteratively inspect each item in a directory for copying or deleting before moving onto any subdirectories.
* `copy_and_delete.py` - an AI created function for backups through copying and deleting any files between the source and target directory without recursive functions.


### R

Some R code for creating backups:

* `backup_files.r` - an R version of the original program `backup_files.py` that was translated from Python
* `copy_and_delete.r` - an implementation of the AI `copy_and_delete.py` in R using the `fs` package.
* `create_backup.r` - a backup program that creates a `.zip` file in a directory to serve as backup. Initially pitched by ChatGPT as a way to backup in R.


### Scripts

Scripting file examples to automate the implementation of the various backup functions.

* `PowerShellPY.sh` - a Shell script to run the orginal `backup_files.py` function.
* `GitBashPY.sh` - a script for running `backup_files.py` through Git Bash.
* `backup_files_script.py` - Python file to import backup functions into another file.
* `Script.R` - an R file for sourcing and running functions.

## Version History

See `NEWS.md` for version history.



