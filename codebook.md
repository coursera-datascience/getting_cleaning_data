Samsung Galaxy S Smartphone Data CodeBookMay 2014
========================================================
#### Coursera Getting Clearning Data Project


## I. Introduction
This file describes the data, the variables, and the work that has been performed to clean up the borrowed dataset of Samsung Galaxy S Smartphone data.

## II. Data Set Description
The borrowed dataset was originally collected from an experiment, which was carried out with a group of 30 volunteers of 19-48 years. Wearing Samsung Galaxy S II smartphone on the waist, each participant performed six activities such as walking, walking upstairs, walking downstairs, sitting, standing, and laying. The phone's embedded accelerometer and gyroscope captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The obtained dataset then was randomly partitioned into two sets, where 70% of the participants was selected for generating the training data and 30% the test data. 

### Files included in the original dataset
The original dataset, which was in the form of a compression file, was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  The extracted dataset folder ("UCI HAR Dataset") contains four text files and two sub-directory folders as shown below:

[UCI HAR Dataset]
<dd> -- activity_labels.txt </dd>
<dd> -- feactures_info.txt </dd>
<dd> -- features.txt </dd>
<dd> -- README.txt </dd>
<dd> -- [test]      </dd>
<dd> -- [train]     </dd>

The 'activity_labels.txt' file links the class labels with their activity name.
The 'features_info.txt' file provides information about the variables used on the feature vector.
The 'features.txt' file lists all features(variables).

In each sub-directory folder of 'test' and 'train', there are three text files and one sub_folder:

[test]    
<dd> -- subject_test.txt </dd>
<dd> -- X_test.txt </dd>
<dd> -- y_test.txt </dd>
<dd> -- [Inertial Signals]    </dd>
[train]       
<dd> -- subject_train.txt </dd>
<dd> -- X_train.txt </dd>
<dd> -- y_train.txt </dd>
<dd> -- [Inertial Signals]   </dd>

The 'subject_test.txt' and 'subject_train.txt' files provide information regarding subjects. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
The 'X_test.txt' and 'X_train.txt' files contain the test and training set data.
The 'y_test.txt' and 'y_train.txt' files conatin the test and training data labels.
The 'Inertial Signals/total_acc_x_train.txt' file contains the acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
The 'Inertial Signals/body_acc_x_train.txt' file contains the body acceleration signal obtained by subtracting the gravity from the total acceleration.
The 'Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

### Attributes
Each record in the original dataset contained the following information:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration
- Triaxial Angular velocity from the gyroscope
- A 561-feature vector with time and frequency domain variables
- Its activity label
- An identifier of the subject who carried out the experiment

## III. Variables in the Original Data Set
The variables in the original dataset come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

## IV. Transformations
For the data cleaning, a R script is created. This 'run_analysis.R' script contains five functions as listed below:

<table border=1>
<tr>
<th>Function Name</th><th>Goal/Task</th><th width="15%">Files Used</th><th>Output File</th><th>Command</th>
</tr>
<tr>
<th valign="top">SimpleMerge</th>
<td valign="top">Merge the training and the test sets into one data set.<br>
1) Subject ID (subject_test.txt and subject_train.txt) is merged as the first column of the merged data set.<br>
2) Activity type (y_test.txt and y_train.txt) is merged as the second column of the merged data set.<br>
3) Descriptive activity information is copied from the activity_labels.txt file.</td>
<td valign="top">1) X_test.txt<br>2) y_test.txt<br>3) X_train.txt<br>4) y_train.txt<br>5) subject_test.txt <br>6) subject_train.txt<br> 7) features.txt</td>
<td valign="top">SimpleMerge.txt<br> (563 variables) <br> (10299 cases)</td>
<td valign="top">SimpleMerge()</td>
</tr>
<tr>
<th valign="top">MeanStdMerge</th>
<td valign="top">Extract only the measurments on the mean and standard deviation (as well as subject id and activity type) for each measurement.<br>
1) At the time of this function call, if SimpleMerge.txt does not exist, this function calls the SimpleMerge() function and creates the SimpleMerge.txt file.<br>
2) If the SimpleMerge.txt file does exist, however, this function reads the file, pattern matches the column names for mean and standard deviation using 'grepl' (as well as 'subjectid' and 'activitytype'), and subset only the matched columns.</td>
<td valign="top">1) SimpleMerge.txt</td>
<td valign="top">MeanStdMerge.txt<br> (68 variables) <br> (10299 cases)</td>
<td valign="top">MeanStdMerge()</td>
</tr>
<tr>
<th valign="top">DesVarMerge</th>
<td valign="top">Label the data set with descriptive variable names.<br>
1) At the time of this function call, if MeanStdMerge.txt does not exist, this function calls the MeanStdMerge() function and creates the MeanStdMerge.txt file.<br>
2) If the MeanStdMerge.txt file does exist, however, this function reads the file and replace the variable names (column headings) descriptive variable names.</td>
<td valign="top">1) MeanStdMerge.txt</td>
<td valign="top">DesVarMerge.txt<br> (68 variables) <br> (10299 cases)</td>
<td valign="top">DesVarMerge()</td>
</tr>
<tr>
<th valign="top">DesActMerge</th>
<td valign="top">Replace activity numbers with descriptive activity names.<br>
1) Descriptive activity information is copied from the activity_labels.txt file.<br>
2) At the time of this function call, if desVarMerge.txt does not exist, this function calls the desVarMerge() function and creates the desVarMerge.txt file.<br>
3) If the desVarMerge.txt file does exist, however, this function reads the file and replace the values of the activity column from numeric code to descriptive activity types.</td>
<td valign="top">1) activity_labels.txt <br> 2) DesVarMerge.txt</td>
<td valign="top">DesActMerge.txt<br> (68 variables) <br> (10299 cases)</td>
<td valign="top">DesActMerge()</td>
</tr>
<th valign="top">AvgMerge</th>
<td valign="top">Create a new tidy data set with the average of each variable for each activity and each subject.<br>
1) At the time of this function call, if desActMerge.txt does not exist, this function calls the desActMerge() function and creates the desActMerge.txt file.<br>
2) If the desActMerge.txt file does exist, however, this function reads the file, loop through each subject and each activity type, and calculate average value of each variable in the dataset (of course, excluding the subject id and activity type column).</td>
<td valign="top">1) activity_labels.txt <br> 2) DesActMerge.txt</td>
<td valign="top">AvgMerge.txt<br> (68 variables) <br> (180 cases)</td>
<td valign="top">AvgMerge()</td>
</tr>
</table>

## V. Variables in the Tidy Data Set
The tidy data set contains a total of 68 variables. 

#### Variable Names

As a part of the data cleaning process (DesVarMerge function), variable names are changed so that they could be more intuitive. The R code changed variable names in the following systematic way:

<table>
<tr><th>From</th><th>To</th><th>Description</th></tr>
<tr><td>[no variable name]</td><td>subjectid</td><td>individual participant's identification number</td></tr>
<tr><td valign="top">[no variable name]</td><td valign="top">activitytype</td><td>type of activity that participant practiced<br>
                                                1) WALKING<br>
                                                2) WALKING_UPSTAIRS<br>
                                                3) WALKING_DOWNSTAIRS<br>
                                                4) SITTING5) STANDING<br>
                                                6) LAYING
</td></tr>
<tr><td>the prefix 't'</td><td>time</td><td>time domain signals</td></tr>
<tr><td>the prefix 'f'</td><td>frequency</td><td>frequency domain signals</td></tr>
<tr><td>Acc</td><td>acceleration</td><td>data from the accelerometer signals</td></tr>
<tr><td>Gyro</td><td>gyroscope</td><td>data from the gyroscope signals</td></tr>
<tr><td>Mag</td><td>magnitude</td><td>magnitude of signals</td></tr>
<tr><td>mean()</td><td>mean</td><td>mean value</td></tr>
<tr><td>std()</td><td>standarddeviation</td><td>standard deviation</td></tr>
</table>
<br>
Additionally, a set of parentheses is replaced by a dot, unless the set is located in the end of the variable name; in that case, parentheses are simply removed. Commas are replaced by a dot as well. All upper case letters are changed to lower case letters. Finally, to indicate that variables other than the subject id and activitytype are the average of each activity and each subject, the prefix of "average" is added to the variable names. The following table lists the variable column location, variable name, and length of variable. 
<br><br>

Variable Column Location | Variable Name | Class | Length | Description
--- | --- | --- | --- | ---
1         |         subjectid	 |      integer	 |  	1	 
2         | 	activitytype	 |      factor	 |  	1	
3        |	average.timebodyacceleration.mean.x	|	numeric	|	1	
4	|	average.timebodyacceleration.mean.y	|	numeric	|	1
5	|	average.timebodyacceleration.mean.z	|	numeric	|	1
6	|	average.timebodyacceleration.standarddeviation.x	|	numeric	|	1
7	|	average.timebodyacceleration.standarddeviation.y	|	numeric	|	1
8	|	average.timebodyacceleration.standarddeviation.z	|	numeric	|	1
9	|	average.timegravityacceleration.mean.x	|	numeric	|	1
10	|	average.timegravityacceleration.mean.y	|	numeric	|	1
11	|        average.timegravityacceleration.mean.z	|	numeric	|	1
12	|	average.timegravityacceleration.standarddeviation.x	|	numeric	|	1
13	|	average.timegravityacceleration.standarddeviation.y	|	numeric	|	1
14	|	average.timegravityacceleration.standarddeviation.z	|	numeric	|	1
15	|	average.timebodyaccelerationjerk.mean.x	|	numeric	|	1
16	|	average.timebodyaccelerationjerk.mean.y	|	numeric	|	1
17	|	average.timebodyaccelerationjerk.mean.z	|	numeric	|	1
18	|	average.timebodyaccelerationjerk.standarddeviation.x	|	numeric	|	1
19	|	average.timebodyaccelerationjerk.standarddeviation.y	|	numeric	|	1
20	|	average.timebodyaccelerationjerk.standarddeviation.z	|	numeric	|	1
21	|        average.timebodygyroscope.mean.x	|	numeric	|	1
22	|	average.timebodygyroscope.mean.y	|	numeric	|	1
23	|	average.timebodygyroscope.mean.z	|	numeric	|	1
24	|	average.timebodygyroscope.standarddeviation.x	|	numeric	|	1
25	|	average.timebodygyroscope.standarddeviation.y	|	numeric	|	1
26	|	average.timebodygyroscope.standarddeviation.z	|	numeric	|	1
27	|	average.timebodygyroscopejerk.mean.x	|	numeric	|	1
28	|	average.timebodygyroscopejerk.mean.y	|	numeric	|	1
29	|	average.timebodygyroscopejerk.mean.z	|	numeric	|	1
30	|	average.timebodygyroscopejerk.standarddeviation.x	|	numeric	|	1
31	|        average.timebodygyroscopejerk.standarddeviation.y	|	numeric	|	1
32	|	average.timebodygyroscopejerk.standarddeviation.z	|	numeric	|	1
33	|	average.timebodyaccelerationmagnitude.mean	|	numeric	|	1
34	|	average.timebodyaccelerationmagnitude.standarddeviation	|	numeric	|	1
35	|	average.timegravityaccelerationmagnitude.mean	|	numeric	|	1
36	|	average.timegravityaccelerationmagnitude.standarddeviation	|	numeric	|	1
37	|	average.timebodyaccelerationjerkmagnitude.mean	|	numeric	|	1
38	|	average.timebodyaccelerationjerkmagnitude.standarddeviation	|	numeric	|	1
39	|	average.timebodygyroscopemagnitude.mean	|	numeric	|	1
40	|	average.timebodygyroscopemagnitude.standarddeviation	|	numeric	|	1
41	|        average.timebodygyroscopejerkmagnitude.mean	|	numeric	|	1
42	|	average.timebodygyroscopejerkmagnitude.standarddeviation	|	numeric	|	1
43	|	average.frequencybodyacceleration.mean.x	|	numeric	|	1
44	|	average.frequencybodyacceleration.mean.y	|	numeric	|	1
45	|	average.frequencybodyacceleration.mean.z	|	numeric	|	1
46	|	average.frequencybodyacceleration.standarddeviation.x	|	numeric	|	1
47	|	average.frequencybodyacceleration.standarddeviation.y	|	numeric	|	1
48	|	average.frequencybodyacceleration.standarddeviation.z	|	numeric	|	1
49	|	average.frequencybodyaccelerationjerk.mean.x	|	numeric	|	1
50	|	average.frequencybodyaccelerationjerk.mean.y	|	numeric	|	1
51	|        average.frequencybodyaccelerationjerk.mean.z	|	numeric	|	1
52	|	average.frequencybodyaccelerationjerk.standarddeviation.x	|	numeric	|	1
53	|	average.frequencybodyaccelerationjerk.standarddeviation.y	|	numeric	|	1
54	|	average.frequencybodyaccelerationjerk.standarddeviation.z	|	numeric	|	1
55	|	average.frequencybodygyroscope.mean.x	|	numeric	|	1
56	|	average.frequencybodygyroscope.mean.y	|	numeric	|	1
57	|	average.frequencybodygyroscope.mean.z	|	numeric	|	1
58	|	average.frequencybodygyroscope.standarddeviation.x	|	numeric	|	1
59	|	average.frequencybodygyroscope.standarddeviation.y	|	numeric	|	1
60	|	average.frequencybodygyroscope.standarddeviation.z	|	numeric	|	1
61	|        average.frequencybodyaccelerationmagnitude.mean	|	numeric	|	1
62	|	average.frequencybodyaccelerationmagnitude.standarddeviation	|	numeric	|	1
63	|	average.frequencybodybodyaccelerationjerkmagnitude.mean	|	numeric	|	1
64	|	average.frequencybodybodyaccelerationjerkmagnitude.standarddeviation	|	numeric	|	1
65	|	average.frequencybodybodygyroscopemagnitude.mean	|	numeric	|	1
66	|	average.frequencybodybodygyroscopemagnitude.standarddeviation	|	numeric	|	1
67	|	average.frequencybodybodygyroscopejerkmagnitude.mean	|	numeric	|	1
68	|	average.frequencybodybodygyroscopejerkmagnitude.standarddeviation	|	numeric	|	1

## VI. Missing Data Code
There exists no missing data.


## VII. Reference
Anguita, D., Ghio, A., Oneto, L., Parra, X., & Reyes-Ortiz, J. L. (2012). Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. 
