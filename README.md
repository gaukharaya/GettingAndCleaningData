Getting and Cleaning Data: Course Project

Introduction

This repository contains code for the course project for the Coursera course "Getting and Cleaning data", part of the Data Science specialization.


The script, run_analysis.R, merges the test and training sets together. Prerequisites for the script:

the UCI HAR Dataset must be extracted and..
the UCI HAR Dataset must be availble in a directory called "UCI HAR Dataset"
After merging testing and training, labels are added and only columns that have to do with mean and standard deviation are kept.

Lastly, the script creates a tidy data set containing the means of all the columns per test subject and per activity. This tidy dataset is written to a comma-delimited file called tidy.txt, which can also be found in this repository.

About the Code Book

The CodeBook.md file explains the transformations performed and the resulting data and variables.