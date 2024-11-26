#NEWS

## Version 1.0.0
* Initial release

## Version 1.1.0
`backup_files.R` is updated to include error handling and output to the console with some suggestions from ChatGPT.
* Incorporated error handing into copy and delete operations such that the entire backup function does not fail when one or more files produce errors in copying or deleting (this has happened when some Windows files are marked read-only).
* Produced console output to update user on status of the backup by displaying the directory pathways of files as well as any copies or deletions that are made.
* Include optional argument to function to toggle on or off the output printed to console. The default is set to print output.
* Reorganized certain code into subset functions to handle individual operations of the process.
* Reordered.