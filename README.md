# Readme
My solutions for already closed Homework-Sessions for the Statistics UE WS22 at TU Vienna

Some files depend on others and import functions for them, so be aware that you must have all files from a certain HW-Folder in the same folder and that you set setwd()
to this folder, otherwise RStudio won't find the functions from imported files. "globalFunctionRepository.R" is imported by every solution file, so if you encounter errors
straight away that the function "file_header" can not be found, make sure that you have all the complete contents of a HW-Folder and that getwd() points to this folder.

Further, i use simulations in some files to verify calculated results by simulating the events in question. Files which use simulations (those files that end with a, for example
"problem 1a.R", "problem 2a.R" etc) usually declare a variable called "sim_iterations", "iterations" or similar which govern how often a simulation runs the events in question.
All simulations were done on a pretty powerful computer, so if simulations run too slow for you, reduce iterations by a factor of ten or more - but be aware that you will sacrifice
simulation accuracy by doing so.
