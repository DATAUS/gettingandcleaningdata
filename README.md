gettingandcleaningdata
======================

The Course Project involves downloading data and then manipulating the data into a clean dataset.

The data has been collected from accelerometers from Samsung Galaxy S smartphones carried by 30 people, aged between 19 and 48 years.  

Each person performed the following six activities:

walking;

walking upstairs;

walking downstairs;

sitting;

standing; and

laying.

The course convenors describes the collection of such data as “One of the most exciting areas in all of data science right now….”.  It is perhaps fortunate that we are not being asked to justify why the measurement of half a dozen mundane activities performed, probably, by a bunch of vacuous egotists (also probably addicted to TwitFace) is “a most exciting area in all of data science”.

The Project involves creating an R script (run_analysis.R) that does the following five steps:

Merges the training and the test sets to create one data set.

Extracts only the measurements on the mean and standard deviation for each measurement.

Uses descriptive activity names to name the activities in the data set.

Appropriately labels the data set with descriptive variable names.

Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


The R script merges two data sets named test and training. 

Only columns that have means and standard deviation are kept and the dataset’s activites are labelled. 

The required tidy data set is then created.

A code book describing the variables is also available in this repo. 


