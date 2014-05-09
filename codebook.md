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

## III. Variables
The variables in the original dataset come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

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
2) Activity type (y_test.txt and y_train.txt) is merged as the second column of the merged data set.</td>
<td valign="top">1) X_test.txt<br>2) y_test.txt<br>3) X_train.txt<br>4) y_train.txt<br>5) subject_test.txt <br>6) subject_train.txt</td>
<td valign="top">simpleMerge.txt<br> (563 variables) <br> (10299 cases)</td>
<td valign="top">simpleMerge()</td>
</tr>
<tr>
<th valign="top">desVarMerge</th>
<td valign="top">Label the data set with descriptive variable names.<br>
1) Descriptive variable names are copied from the features.txt file.<br>
2) At the time of this function call, if simpleMerge.txt does not exist, this function calls the simpleMerge() function and creates the simpleMerge.txt file.<br>
3) If the simpleMerge.txt file does exist, however, this function reads the file and replace the variable names (column headings) descriptive variable names.</td>
<td valign="top">1) features.txt <br> 2) simpleMerge.txt</td>
<td valign="top">desVarMerge.txt<br> (563 variables) <br> (10299 cases)</td>
<td valign="top">desVarMerge()</td>
</tr>
<tr>
<th valign="top">desActMerge</th>
<td valign="top">Replace activity numbers with descriptive activity names.<br>
1) Descriptive activity information is copied from the activity_labels.txt file.<br>
2) At the time of this function call, if desVarMerge.txt does not exist, this function calls the desVarMerge() function and creates the desVarMerge.txt file.<br>
3) If the desVarMerge.txt file does exist, however, this function reads the file and replace the values of the activity column from numeric code to descriptive activity types.</td>
<td valign="top">1) activity_labels.txt <br> 2) desVarMerge.txt</td>
<td valign="top">desActMerge.txt<br> (563 variables) <br> (10299 cases)</td>
<td valign="top">desActMerge()</td>
</tr>
<tr>
<th valign="top">meanStdMerge</th>
<td valign="top">Extract only the measurments on the mean and standard deviation for each measurement.<br>
1) At the time of this function call, if desVarMerge.txt does not exist, this function calls the desVarMerge() function and creates the desVarMerge.txt file.<br>
2) If the desVarMerge.txt file does exist, however, this function reads the file, pattern matches the column names for mean and standard deviation using 'grepl', and subset only the matched columns.</td>
<td valign="top">1) desActMerge.txt</td>
<td valign="top">meanStdMerge.txt<br> (57 variables) <br> (10299 cases)</td>
<td valign="top">meanStdMerge()</td>
</tr>
<th valign="top">avgMerge</th>
<td valign="top">Create a new tidy data set with the average of each variable for each activity and each subject.<br>
1) At the time of this function call, if desVarMerge.txt does not exist, this function calls the desVarMerge() function and creates the desVarMerge.txt file.<br>
2) If the desVarMerge.txt file does exist, however, this function reads the file, loop through each subject and each activity type, and calculate average value of each variable in the dataset (of course, excluding the subject id and activity type column).</td>
<td valign="top">1) activity_labels.txt <br> 2) desVarMerge.txt</td>
<td valign="top">avgMerge.txt<br> (563 variables) <br> (10299 cases)</td>
<td valign="top">avgMerge()</td>
</tr>
</table>

## V. Missing Data Code
There exists no missing data.

## VI. Variable Details
When fully merged with descriptive variable names and activity names, the file contains a total of 563 variables. The following lists the variable column location, variable name, length of variable, and description if not explained previously in this document. 

<strong><font color="blue">While the instructor indicated in his video lectures that the variable names need to be all lowercase letters without any special characters, it seemed to me that the original dataset's variable names (combination of Upper case and lower case, with special characters like hypens and commas) make the variables in the project quite more readable. Thus, the original variable names are kept for the project.</font></strong>

Variable Column Location | Variable Name | Class | Length | Description
--- | --- | --- | --- | ---
1         |         subjectID	 |      integer	 |  	1	 | 	individual participant's identification number
2	 | 	activitytype	 |      factor	 |  	1	 | 	type of activity that participant practiced 
	 | 		 | 	 |       | 	1) WALKING
	 | 		 | 	|	 | 	2) WALKING_UPSTAIRS
	 | 		 | 	|	 | 	3) WALKING_DOWNSTAIRS
	 | 		 | 	|	 | 	4) SITTING
	 | 		 | 	|	 | 	5) STANDING
	 | 		 | 	|	 | 	6) LAYING
3	 | 	tBodyAcc-mean()-X	 | numeric | 	1	 | 	
4	 | 	tBodyAcc-mean()-Y	 | numeric |  	1	 | 	
5	 | 	tBodyAcc-mean()-Z	 | numeric |  	1	 | 	
6	 | 	tBodyAcc-std()-X	 | numeric |  	1	 | 	
7	 | 	tBodyAcc-std()-Y	 | numeric |  	1	 | 	
8	 | 	tBodyAcc-std()-Z	 | numeric |  	1	 | 	
9	 | 	tBodyAcc-mad()-X	 | numeric |  	1	 | 	
10	 | 	tBodyAcc-mad()-Y	 | numeric |  	1	 | 	
11	 | 	tBodyAcc-mad()-Z	 | numeric |  	1	 | 	
12	 | 	tBodyAcc-max()-X	 | numeric |  	1	 | 	
13	 | 	tBodyAcc-max()-Y	 | numeric |  	1	 | 	
14	 | 	tBodyAcc-max()-Z	 | numeric | 	1	 |	
15	 | 	tBodyAcc-min()-X	 | numeric | 	1	 |	
16	 | 	tBodyAcc-min()-Y	 | numeric | 	1	 |	
17	 | 	tBodyAcc-min()-Z	 | numeric | 	1	 |	
18	 | 	tBodyAcc-sma()	 | numeric | 	1	 |	
19	 | 	tBodyAcc-energy()-X	 | numeric | 	1	 |	
20	 | 	tBodyAcc-energy()-Y	 | numeric | 	1	 |	
21	 | 	tBodyAcc-energy()-Z	 | numeric | 	1	 |	
22	 | 	tBodyAcc-iqr()-X	 | numeric | 	1	 |	
23	 | 	tBodyAcc-iqr()-Y	 | numeric | 	1	 |	
24	 | 	tBodyAcc-iqr()-Z	 | numeric | 	1	 |	
25	 | 	tBodyAcc-entropy()-X	 | numeric | 	1	 |	
26	 | 	tBodyAcc-entropy()-Y	 | numeric | 	1	 |	
27	 | 	tBodyAcc-entropy()-Z	 | numeric | 	1	 |	
28	 | 	tBodyAcc-arCoeff()-X,1	| numeric  | 	1	 | 	
29	 | 	tBodyAcc-arCoeff()-X,2	 | numeric | 	1	 |	
30	 | 	tBodyAcc-arCoeff()-X,3	 | numeric | 	1	 |	
31	 | 	tBodyAcc-arCoeff()-X,4	 | numeric | 	1	 |	
32	 | 	tBodyAcc-arCoeff()-Y,1	 | numeric | 	1	 |	
33	 | 	tBodyAcc-arCoeff()-Y,2	 | numeric | 	1	 |	
34	 | 	tBodyAcc-arCoeff()-Y,3	 | numeric | 	1	 |	
35	 | 	tBodyAcc-arCoeff()-Y,4	 | numeric | 	1	 |	
36	 | 	tBodyAcc-arCoeff()-Z,1	 | numeric | 	1	 |	
37	 | 	tBodyAcc-arCoeff()-Z,2	 | numeric | 	1	 |	
38	 | 	tBodyAcc-arCoeff()-Z,3	 | numeric | 	1	 | 	
39	 | 	tBodyAcc-arCoeff()-Z,4	 | numeric | 	1	 | 	
40	 | 	tBodyAcc-correlation()-X,Y	 | numeric | 	1	 | 	
41	 | 	tBodyAcc-correlation()-X,Z	 | numeric | 	1	 | 	
42	 | 	tBodyAcc-correlation()-Y,Z	 | numeric | 	1	 | 	
43	 | 	tGravityAcc-mean()-X	 | numeric | 	1	 | 	
44	 | 	tGravityAcc-mean()-Y	 | numeric | 	1	 | 	
45	 | 	tGravityAcc-mean()-Z	 | numeric | 	1	 | 	
46	 | 	tGravityAcc-std()-X	 | numeric | 	1	 | 	
47	 | 	tGravityAcc-std()-Y	 | numeric | 	1	 | 	
48	 | 	tGravityAcc-std()-Z	 | numeric | 	1	 | 	
49	 | 	tGravityAcc-mad()-X	 | numeric | 	1	 | 	
50	 | 	tGravityAcc-mad()-Y	 | numeric | 	1	 | 	
51	 | 	tGravityAcc-mad()-Z	 | numeric | 	1	 | 	
52	 | 	tGravityAcc-max()-X	 | numeric | 	1	 | 	
53	 | 	tGravityAcc-max()-Y	 | numeric | 	1	 | 	
54	 | 	tGravityAcc-max()-Z	 | numeric | 	1	 | 	
55	 | 	tGravityAcc-min()-X	 | numeric | 	1	 | 	
56	 | 	tGravityAcc-min()-Y	 | numeric | 	1	 | 	
57	 | 	tGravityAcc-min()-Z	 | numeric | 	1	 | 	
58	 | 	tGravityAcc-sma()	 | numeric | 	1	 | 	
59	 | 	tGravityAcc-energy()-X	 | numeric | 	1	 | 	
60	 | 	tGravityAcc-energy()-Y	 | numeric | 	1	 | 	
61	 | 	tGravityAcc-energy()-Z	 | numeric | 	1	 | 	
62	 | 	tGravityAcc-iqr()-X	 | numeric | 	1	 | 	
63	 | 	tGravityAcc-iqr()-Y	 | numeric | 	1	 | 	
64	 | 	tGravityAcc-iqr()-Z	 | numeric | 	1	 | 	
65	 | 	tGravityAcc-entropy()-X	 | numeric | 	1	 | 	
66	 | 	tGravityAcc-entropy()-Y	 | numeric | 	1	 | 	
67	 | 	tGravityAcc-entropy()-Z	 | numeric | 	1	 | 	
68	 | 	tGravityAcc-arCoeff()-X,1	 | numeric | 	1	 | 	
69	 | 	tGravityAcc-arCoeff()-X,2	 | numeric | 	1	 | 	
70	 | 	tGravityAcc-arCoeff()-X,3	 | numeric | 	1	 | 	
71	 | 	tGravityAcc-arCoeff()-X,4	 | numeric | 	1	 | 	
72	 | 	tGravityAcc-arCoeff()-Y,1	 | numeric | 	1	 | 	
73	 | 	tGravityAcc-arCoeff()-Y,2	 | numeric | 	1	 | 	
74	 | 	tGravityAcc-arCoeff()-Y,3	 | numeric | 	1	 | 	
75	 | 	tGravityAcc-arCoeff()-Y,4	 | numeric | 	1	 | 	
76	 | 	tGravityAcc-arCoeff()-Z,1	 | numeric | 	1	 | 	
77	 | 	tGravityAcc-arCoeff()-Z,2	 | numeric | 	1	 | 	
78	 | 	tGravityAcc-arCoeff()-Z,3	 | numeric | 	1	 | 	
79	 | 	tGravityAcc-arCoeff()-Z,4	 | numeric | 	1	 | 	
80	 | 	tGravityAcc-correlation()-X,Y	 | numeric | 	1	 | 	
81	 | 	tGravityAcc-correlation()-X,Z	 | numeric | 	1	 | 	
82	 | 	tGravityAcc-correlation()-Y,Z	 | numeric | 	1	 | 	
83	 | 	tBodyAccJerk-mean()-X	 | numeric | 	1	 | 	
84	 | 	tBodyAccJerk-mean()-Y	 | numeric | 	1	 | 	
85	 | 	tBodyAccJerk-mean()-Z	 | numeric | 	1	 | 	
86	 | 	tBodyAccJerk-std()-X	 | numeric | 	1	 | 	
87	 | 	tBodyAccJerk-std()-Y	 | numeric | 	1	 | 	
88	 | 	tBodyAccJerk-std()-Z	 | numeric | 	1	 | 	
89	 | 	tBodyAccJerk-mad()-X	 | numeric | 	1	 | 	
90	 | 	tBodyAccJerk-mad()-Y	 | numeric | 	1	 | 	
91	 | 	tBodyAccJerk-mad()-Z	 | numeric | 	1	 | 	
92	 | 	tBodyAccJerk-max()-X	 | numeric | 	1	 | 	
93	 | 	tBodyAccJerk-max()-Y	 | numeric | 	1	 | 	
94	 | 	tBodyAccJerk-max()-Z	 | numeric | 	1	 | 	
95	 | 	tBodyAccJerk-min()-X	 | numeric | 	1	 | 	
96	 | 	tBodyAccJerk-min()-Y	 | numeric | 	1	 | 	
97	 | 	tBodyAccJerk-min()-Z	 | numeric | 	1	 | 	
98	 | 	tBodyAccJerk-sma()	 | numeric | 	1	 | 	
99	 | 	tBodyAccJerk-energy()-X	 | numeric | 	1	 | 	
100	 | 	tBodyAccJerk-energy()-Y	 | numeric | 	1	 | 	
101	 | 	tBodyAccJerk-energy()-Z	 | numeric | 	1	 | 	
102	 | 	tBodyAccJerk-iqr()-X	 | numeric | 	1	 | 	
103	 | 	tBodyAccJerk-iqr()-Y	 | numeric | 	1	 | 	
104	 | 	tBodyAccJerk-iqr()-Z	 | numeric | 	1	 | 	
105	 | 	tBodyAccJerk-entropy()-X	 | numeric | 	1	 | 	
106	 | 	tBodyAccJerk-entropy()-Y	 | numeric | 	1	 | 	
107	 | 	tBodyAccJerk-entropy()-Z	 | numeric | 	1	 | 	
108	 | 	tBodyAccJerk-arCoeff()-X,1	 | numeric | 	1	 | 	
109	 | 	tBodyAccJerk-arCoeff()-X,2	 | numeric | 	1	 | 	
110	 | 	tBodyAccJerk-arCoeff()-X,3	 | numeric | 	1	 | 	
111	 | 	tBodyAccJerk-arCoeff()-X,4	 | numeric | 	1	 | 	
112	 | 	tBodyAccJerk-arCoeff()-Y,1	 | numeric | 	1	 | 	
113	 | 	tBodyAccJerk-arCoeff()-Y,2	 | numeric | 	1	 | 	
114	 | 	tBodyAccJerk-arCoeff()-Y,3	 | numeric | 	1	 | 	
115	 | 	tBodyAccJerk-arCoeff()-Y,4	 | numeric | 	1	 | 	
116	 | 	tBodyAccJerk-arCoeff()-Z,1	 | numeric | 	1	 | 	
117	 | 	tBodyAccJerk-arCoeff()-Z,2	 | numeric | 	1	 | 	
118	 | 	tBodyAccJerk-arCoeff()-Z,3	 | numeric | 	1	 | 	
119	 | 	tBodyAccJerk-arCoeff()-Z,4	 | numeric | 	1	 | 	
120	 | 	tBodyAccJerk-correlation()-X,Y	 | numeric | 	1	 | 	
121	 | 	tBodyAccJerk-correlation()-X,Z	 | numeric | 	1	 | 	
122	 | 	tBodyAccJerk-correlation()-Y,Z	 | numeric | 	1	 | 	
123	 | 	tBodyGyro-mean()-X	 | numeric | 	1	 | 	
124	 | 	tBodyGyro-mean()-Y	 | numeric | 	1	 | 	
125	 | 	tBodyGyro-mean()-Z	 | numeric | 	1	 | 	
126	 | 	tBodyGyro-std()-X	 | numeric | 	1	 | 	
127	 | 	tBodyGyro-std()-Y	 | numeric | 	1	 | 	
128	 | 	tBodyGyro-std()-Z	 | numeric | 	1	 | 	
129	 | 	tBodyGyro-mad()-X	 | numeric | 	1	 | 	
130	 | 	tBodyGyro-mad()-Y	 | numeric | 	1	 | 	
131	 | 	tBodyGyro-mad()-Z	 | numeric | 	1	 | 	
132	 | 	tBodyGyro-max()-X	 | numeric | 	1	 | 	
133	 | 	tBodyGyro-max()-Y	 | numeric | 	1	 | 	
134	 | 	tBodyGyro-max()-Z	 | numeric | 	1	 | 	
135	 | 	tBodyGyro-min()-X	 | numeric | 	1	 | 	
136	 | 	tBodyGyro-min()-Y	 | numeric | 	1	 | 	
137	 | 	tBodyGyro-min()-Z	 | numeric | 	1	 | 	
138	 | 	tBodyGyro-sma()	 | numeric | 	1	 | 	
139	 | 	tBodyGyro-energy()-X	 | numeric | 	1	 | 	
140	 | 	tBodyGyro-energy()-Y	 | numeric | 	1	 | 	
141	 | 	tBodyGyro-energy()-Z	 | numeric | 	1	 | 	
142	 | 	tBodyGyro-iqr()-X	 | numeric | 	1	 | 	
143	 | 	tBodyGyro-iqr()-Y	 | numeric | 	1	 | 	
144	 | 	tBodyGyro-iqr()-Z	 | numeric | 	1	 | 	
145	 | 	tBodyGyro-entropy()-X	 | numeric | 	1	 | 	
146	 | 	tBodyGyro-entropy()-Y	 | numeric | 	1	 | 	
147	 | 	tBodyGyro-entropy()-Z	 | numeric | 	1	 | 	
148	 | 	tBodyGyro-arCoeff()-X,1	 | numeric | 	1	 | 	
149	 | 	tBodyGyro-arCoeff()-X,2	 | numeric | 	1	 | 	
150	 | 	tBodyGyro-arCoeff()-X,3	 | numeric | 	1	 | 	
151	 | 	tBodyGyro-arCoeff()-X,4	 | numeric | 	1	 | 	
152	 | 	tBodyGyro-arCoeff()-Y,1	 | numeric | 	1	 | 	
153	 | 	tBodyGyro-arCoeff()-Y,2	 | numeric | 	1	 | 	
154	 | 	tBodyGyro-arCoeff()-Y,3	 | numeric | 	1	 | 	
155	 | 	tBodyGyro-arCoeff()-Y,4	 | numeric | 	1	 | 	
156	 | 	tBodyGyro-arCoeff()-Z,1	 | numeric | 	1	 | 	
157	 | 	tBodyGyro-arCoeff()-Z,2	 | numeric | 	1	 | 	
158	 | 	tBodyGyro-arCoeff()-Z,3	 | numeric | 	1	 | 	
159	 | 	tBodyGyro-arCoeff()-Z,4	 | numeric | 	1	 | 	
160	 | 	tBodyGyro-correlation()-X,Y	 | numeric | 	1	 | 	
161	 | 	tBodyGyro-correlation()-X,Z	 | numeric | 	1	 | 	
162	 | 	tBodyGyro-correlation()-Y,Z	 | numeric | 	1	 | 	
163	 | 	tBodyGyroJerk-mean()-X	 | numeric | 	1	 | 	
164	 | 	tBodyGyroJerk-mean()-Y	 | numeric | 	1	 | 	
165	 | 	tBodyGyroJerk-mean()-Z	 | numeric | 	1	 | 	
166	 | 	tBodyGyroJerk-std()-X	 | numeric | 	1	 | 	
167	 | 	tBodyGyroJerk-std()-Y	 | numeric | 	1	 | 	
168	 | 	tBodyGyroJerk-std()-Z	 | numeric | 	1	 | 	
169	 | 	tBodyGyroJerk-mad()-X	 | numeric | 	1	 | 	
170	 | 	tBodyGyroJerk-mad()-Y	 | numeric | 	1	 | 	
171	 | 	tBodyGyroJerk-mad()-Z	 | numeric | 	1	 | 	
172	 | 	tBodyGyroJerk-max()-X	 | numeric | 	1	 | 	
173	 | 	tBodyGyroJerk-max()-Y	 | numeric | 	1	 | 	
174	 | 	tBodyGyroJerk-max()-Z	 | numeric | 	1	 | 	
175	 | 	tBodyGyroJerk-min()-X	 | numeric | 	1	 | 	
176	 | 	tBodyGyroJerk-min()-Y	 | numeric | 	1	 | 	
177	 | 	tBodyGyroJerk-min()-Z	 | numeric | 	1	 | 	
178	 | 	tBodyGyroJerk-sma()	 | numeric | 	1	 | 	
179	 | 	tBodyGyroJerk-energy()-X	 | numeric | 	1	 | 	
180	 | 	tBodyGyroJerk-energy()-Y	 | numeric | 	1	 | 	
181	 | 	tBodyGyroJerk-energy()-Z	 | numeric | 	1	 | 	
182	 | 	tBodyGyroJerk-iqr()-X	 | numeric | 	1	 | 	
183	 | 	tBodyGyroJerk-iqr()-Y	 | numeric | 	1	 | 	
184	 | 	tBodyGyroJerk-iqr()-Z	 | numeric | 	1	 | 	
185	 | 	tBodyGyroJerk-entropy()-X	 | numeric | 	1	 | 	
186	 | 	tBodyGyroJerk-entropy()-Y	 | numeric | 	1	 | 	
187	 | 	tBodyGyroJerk-entropy()-Z	 | numeric | 	1	 | 	
188	 | 	tBodyGyroJerk-arCoeff()-X,1	 | numeric | 	1	 | 	
189	 | 	tBodyGyroJerk-arCoeff()-X,2	 | numeric | 	1	 | 	
190	 | 	tBodyGyroJerk-arCoeff()-X,3	 | numeric | 	1	 | 	
191	 | 	tBodyGyroJerk-arCoeff()-X,4	 | numeric | 	1	 | 	
192	 | 	tBodyGyroJerk-arCoeff()-Y,1	 | numeric | 	1	 | 	
193	 | 	tBodyGyroJerk-arCoeff()-Y,2	 | numeric | 	1	 | 	
194	 | 	tBodyGyroJerk-arCoeff()-Y,3	 | numeric | 	1	 | 	
195	 | 	tBodyGyroJerk-arCoeff()-Y,4	 | numeric | 	1	 | 	
196	 | 	tBodyGyroJerk-arCoeff()-Z,1	 | numeric | 	1	 | 	
197	 | 	tBodyGyroJerk-arCoeff()-Z,2	 | numeric | 	1	 | 	
198	 | 	tBodyGyroJerk-arCoeff()-Z,3	 | numeric | 	1	 | 	
199	 | 	tBodyGyroJerk-arCoeff()-Z,4	 | numeric | 	1	 | 	
200	 | 	tBodyGyroJerk-correlation()-X,Y	 | numeric | 	1	 | 	
201	 | 	tBodyGyroJerk-correlation()-X,Z	 | numeric | 	1	 | 	
202	 | 	tBodyGyroJerk-correlation()-Y,Z	 | numeric | 	1	 | 	
203	 | 	tBodyAccMag-mean()	 | numeric | 	1	 | 	
204	 | 	tBodyAccMag-std()	 | numeric | 	1	 | 	
205	 | 	tBodyAccMag-mad()	 | numeric | 	1	 | 	
206	 | 	tBodyAccMag-max()	 | numeric | 	1	 | 	
207	 | 	tBodyAccMag-min()	 | numeric | 	1	 | 	
208	 | 	tBodyAccMag-sma()	 | numeric | 	1	 | 	
209	 | 	tBodyAccMag-energy()	 | numeric | 	1	 | 	
210	 | 	tBodyAccMag-iqr()	 | numeric | 	1	 | 	
211	 | 	tBodyAccMag-entropy()	 | numeric | 	1	 | 	
212	 | 	tBodyAccMag-arCoeff()1	 | numeric | 	1	 | 	
213	 | 	tBodyAccMag-arCoeff()2	 | numeric | 	1	 | 	
214	 | 	tBodyAccMag-arCoeff()3	 | numeric | 	1	 | 	
215	 | 	tBodyAccMag-arCoeff()4	 | numeric | 	1	 | 	
216	 | 	tGravityAccMag-mean()	 | numeric | 	1	 | 	
217	 | 	tGravityAccMag-std()	 | numeric | 	1	 | 	
218	 | 	tGravityAccMag-mad()	 | numeric | 	1	 | 	
219	 | 	tGravityAccMag-max()	 | numeric | 	1	 | 	
220	 | 	tGravityAccMag-min()	 | numeric | 	1	 | 	
221	 | 	tGravityAccMag-sma()	 | numeric | 	1	 | 	
222	 | 	tGravityAccMag-energy()	 | numeric | 	1	 | 	
223	 | 	tGravityAccMag-iqr()	 | numeric | 	1	 | 	
224	 | 	tGravityAccMag-entropy()	 | numeric | 	1	 | 	
225	 | 	tGravityAccMag-arCoeff()1	 | numeric | 	1	 | 	
226	 | 	tGravityAccMag-arCoeff()2	 | numeric | 	1	 | 	
227	 | 	tGravityAccMag-arCoeff()3	 | numeric | 	1	 | 	
228	 | 	tGravityAccMag-arCoeff()4	 | numeric | 	1	 | 	
229	 | 	tBodyAccJerkMag-mean()	 | numeric | 	1	 | 	
230	 | 	tBodyAccJerkMag-std()	 | numeric | 	1	 | 	
231	 | 	tBodyAccJerkMag-mad()	 | numeric | 	1	 | 	
232	 | 	tBodyAccJerkMag-max()	 | numeric | 	1	 | 	
233	 | 	tBodyAccJerkMag-min()	 | numeric | 	1	 | 	
234	 | 	tBodyAccJerkMag-sma()	 | numeric | 	1	 | 	
235	 | 	tBodyAccJerkMag-energy()	 | numeric | 	1	 | 	
236	 | 	tBodyAccJerkMag-iqr()	 | numeric | 	1	 | 	
237	 | 	tBodyAccJerkMag-entropy()	 | numeric | 	1	 | 	
238	 | 	tBodyAccJerkMag-arCoeff()1	 | numeric | 	1	 | 	
239	 | 	tBodyAccJerkMag-arCoeff()2	 | numeric | 	1	 | 	
240	 | 	tBodyAccJerkMag-arCoeff()3	 | numeric | 	1	 | 	
241	 | 	tBodyAccJerkMag-arCoeff()4	 | numeric | 	1	 | 	
242	 | 	tBodyGyroMag-mean()	 | numeric | 	1	 | 	
243	 | 	tBodyGyroMag-std()	 | numeric | 	1	 | 	
244	 | 	tBodyGyroMag-mad()	 | numeric | 	1	 | 	
245	 | 	tBodyGyroMag-max()	 | numeric | 	1	 | 	
246	 | 	tBodyGyroMag-min()	 | numeric | 	1	 | 	
247	 | 	tBodyGyroMag-sma()	 | numeric | 	1	 | 	
248	 | 	tBodyGyroMag-energy()	 | numeric | 	1	 | 	
249	 | 	tBodyGyroMag-iqr()	 | numeric | 	1	 | 	
250	 | 	tBodyGyroMag-entropy()	 | numeric | 	1	 | 	
251	 | 	tBodyGyroMag-arCoeff()1	 | numeric | 	1	 | 	
252	 | 	tBodyGyroMag-arCoeff()2	 | numeric | 	1	 | 	
253	 | 	tBodyGyroMag-arCoeff()3	 | numeric | 	1	 | 	
254	 | 	tBodyGyroMag-arCoeff()4	 | numeric | 	1	 | 	
255	 | 	tBodyGyroJerkMag-mean()	 | numeric | 	1	 | 	
256	 | 	tBodyGyroJerkMag-std()	 | numeric | 	1	 | 	
257	 | 	tBodyGyroJerkMag-mad()	 | numeric | 	1	 | 	
258	 | 	tBodyGyroJerkMag-max()	 | numeric | 	1	 | 	
259	 | 	tBodyGyroJerkMag-min()	 | numeric | 	1	 | 	
260	 | 	tBodyGyroJerkMag-sma()	 | numeric | 	1	 | 	
261	 | 	tBodyGyroJerkMag-energy()	 | numeric | 	1	 | 	
262	 | 	tBodyGyroJerkMag-iqr()	 | numeric | 	1	 | 	
263	 | 	tBodyGyroJerkMag-entropy()	 | numeric | 	1	 | 	
264	 | 	tBodyGyroJerkMag-arCoeff()1	 | numeric | 	1	 | 	
265	 | 	tBodyGyroJerkMag-arCoeff()2	 | numeric | 	1	 | 	
266	 | 	tBodyGyroJerkMag-arCoeff()3	 | numeric | 	1	 | 	
267	 | 	tBodyGyroJerkMag-arCoeff()4	 | numeric | 	1	 | 	
268	 | 	fBodyAcc-mean()-X	 | numeric | 	1	 | 	
269	 | 	fBodyAcc-mean()-Y	 | numeric | 	1	 | 	
270	 | 	fBodyAcc-mean()-Z	 | numeric | 	1	 | 	
271	 | 	fBodyAcc-std()-X	 | numeric | 	1	 | 	
272	 | 	fBodyAcc-std()-Y	 | numeric | 	1	 | 	
273	 | 	fBodyAcc-std()-Z	 | numeric | 	1	 | 	
274	 | 	fBodyAcc-mad()-X	 | numeric | 	1	 | 	
275	 | 	fBodyAcc-mad()-Y	 | numeric | 	1	 | 	
276	 | 	fBodyAcc-mad()-Z	 | numeric | 	1	 | 	
277	 | 	fBodyAcc-max()-X	 | numeric | 	1	 | 	
278	 | 	fBodyAcc-max()-Y	 | numeric | 	1	 | 	
279	 | 	fBodyAcc-max()-Z	 | numeric | 	1	 | 	
280	 | 	fBodyAcc-min()-X	 | numeric | 	1	 | 	
281	 | 	fBodyAcc-min()-Y	 | numeric | 	1	 | 	
282	 | 	fBodyAcc-min()-Z	 | numeric | 	1	 | 	
283	 | 	fBodyAcc-sma()	 | numeric | 	1	 | 	
284	 | 	fBodyAcc-energy()-X	 | numeric | 	1	 | 	
285	 | 	fBodyAcc-energy()-Y	 | numeric | 	1	 | 	
286	 | 	fBodyAcc-energy()-Z	 | numeric | 	1	 | 	
287	 | 	fBodyAcc-iqr()-X	 | numeric | 	1	 | 	
288	 | 	fBodyAcc-iqr()-Y	 | numeric | 	1	 | 	
289	 | 	fBodyAcc-iqr()-Z	 | numeric | 	1	 | 	
290	 | 	fBodyAcc-entropy()-X	 | numeric | 	1	 | 	
291	 | 	fBodyAcc-entropy()-Y	 | numeric | 	1	 | 	
292	 | 	fBodyAcc-entropy()-Z	 | numeric | 	1	 | 	
293	 | 	fBodyAcc-maxInds-X	 | numeric | 	1	 | 	
294	 | 	fBodyAcc-maxInds-Y	 | numeric | 	1	 | 	
295	 | 	fBodyAcc-maxInds-Z	 | numeric | 	1	 | 	
296	 | 	fBodyAcc-meanFreq()-X	 | numeric | 	1	 | 	
297	 | 	fBodyAcc-meanFreq()-Y	 | numeric | 	1	 | 	
298	 | 	fBodyAcc-meanFreq()-Z	 | numeric | 	1	 | 	
299	 | 	fBodyAcc-skewness()-X	 | numeric | 	1	 | 	
300	 | 	fBodyAcc-kurtosis()-X	 | numeric | 	1	 | 	
301	 | 	fBodyAcc-skewness()-Y	 | numeric | 	1	 | 	
302	 | 	fBodyAcc-kurtosis()-Y	 | numeric | 	1	 | 	
303	 | 	fBodyAcc-skewness()-Z	 | numeric | 	1	 | 	
304	 | 	fBodyAcc-kurtosis()-Z	 | numeric | 	1	 | 	
305	 | 	fBodyAcc-bandsEnergy()-1,8	 | numeric | 	1	 | 	
306	 | 	fBodyAcc-bandsEnergy()-9,16	 | numeric | 	1	 | 	
307	 | 	fBodyAcc-bandsEnergy()-17,24	 | numeric | 	1	 | 	
308	 | 	fBodyAcc-bandsEnergy()-25,32	 | numeric | 	1	 | 	
309	 | 	fBodyAcc-bandsEnergy()-33,40	 | numeric | 	1	 | 	
310	 | 	fBodyAcc-bandsEnergy()-41,48	 | numeric | 	1	 | 	
311	 | 	fBodyAcc-bandsEnergy()-49,56	 | numeric | 	1	 | 	
312	 | 	fBodyAcc-bandsEnergy()-57,64	 | numeric | 	1	 | 	
313	 | 	fBodyAcc-bandsEnergy()-1,16	 | numeric | 	1	 | 	
314	 | 	fBodyAcc-bandsEnergy()-17,32	 | numeric | 	1	 | 	
315	 | 	fBodyAcc-bandsEnergy()-33,48	 | numeric | 	1	 | 	
316	 | 	fBodyAcc-bandsEnergy()-49,64	 | numeric | 	1	 | 	
317	 | 	fBodyAcc-bandsEnergy()-1,24	 | numeric | 	1	 | 	
318	 | 	fBodyAcc-bandsEnergy()-25,48	 | numeric | 	1	 | 	
319	 | 	fBodyAcc-bandsEnergy()-1,8	 | numeric | 	1	 | 	
320	 | 	fBodyAcc-bandsEnergy()-9,16	 | numeric | 	1	 | 	
321	 | 	fBodyAcc-bandsEnergy()-17,24	 | numeric | 	1	 | 	
322	 | 	fBodyAcc-bandsEnergy()-25,32	 | numeric | 	1	 | 	
323	 | 	fBodyAcc-bandsEnergy()-33,40	 | numeric | 	1	 | 	
324	 | 	fBodyAcc-bandsEnergy()-41,48	 | numeric | 	1	 | 	
325	 | 	fBodyAcc-bandsEnergy()-49,56	 | numeric | 	1	 | 	
326	 | 	fBodyAcc-bandsEnergy()-57,64	 | numeric | 	1	 | 	
327	 | 	fBodyAcc-bandsEnergy()-1,16	 | numeric | 	1	 | 	
328	 | 	fBodyAcc-bandsEnergy()-17,32	 | numeric | 	1	 | 	
329	 | 	fBodyAcc-bandsEnergy()-33,48	 | numeric | 	1	 | 	
330	 | 	fBodyAcc-bandsEnergy()-49,64	 | numeric | 	1	 | 	
331	 | 	fBodyAcc-bandsEnergy()-1,24	 | numeric | 	1	 | 	
332	 | 	fBodyAcc-bandsEnergy()-25,48	 | numeric | 	1	 | 	
333	 | 	fBodyAcc-bandsEnergy()-1,8	 | numeric | 	1	 | 	
334	 | 	fBodyAcc-bandsEnergy()-9,16	 | numeric | 	1	 | 	
335	 | 	fBodyAcc-bandsEnergy()-17,24	 | numeric | 	1	 | 	
336	 | 	fBodyAcc-bandsEnergy()-25,32	 | numeric | 	1	 | 	
337	 | 	fBodyAcc-bandsEnergy()-33,40	 | numeric | 	1	 | 	
338	 | 	fBodyAcc-bandsEnergy()-41,48	 | numeric | 	1	 | 	
339	 | 	fBodyAcc-bandsEnergy()-49,56	 | numeric | 	1	 | 	
340	 | 	fBodyAcc-bandsEnergy()-57,64	 | numeric | 	1	 | 	
341	 | 	fBodyAcc-bandsEnergy()-1,16	 | numeric | 	1	 | 	
342	 | 	fBodyAcc-bandsEnergy()-17,32	 | numeric | 	1	 | 	
343	 | 	fBodyAcc-bandsEnergy()-33,48	 | numeric | 	1	 | 	
344	 | 	fBodyAcc-bandsEnergy()-49,64	 | numeric | 	1	 | 	
345	 | 	fBodyAcc-bandsEnergy()-1,24	 | numeric | 	1	 | 	
346	 | 	fBodyAcc-bandsEnergy()-25,48	 | numeric | 	1	 | 	
347	 | 	fBodyAccJerk-mean()-X	 | numeric | 	1	 | 	
348	 | 	fBodyAccJerk-mean()-Y	 | numeric | 	1	 | 	
349	 | 	fBodyAccJerk-mean()-Z	 | numeric | 	1	 | 	
350	 | 	fBodyAccJerk-std()-X	 | numeric | 	1	 | 	
351	 | 	fBodyAccJerk-std()-Y	 | numeric | 	1	 | 	
352	 | 	fBodyAccJerk-std()-Z	 | numeric | 	1	 | 	
353	 | 	fBodyAccJerk-mad()-X	 | numeric | 	1	 | 	
354	 | 	fBodyAccJerk-mad()-Y	 | numeric | 	1	 | 	
355	 | 	fBodyAccJerk-mad()-Z	 | numeric | 	1	 | 	
356	 | 	fBodyAccJerk-max()-X	 | numeric | 	1	 | 	
357	 | 	fBodyAccJerk-max()-Y	 | numeric | 	1	 | 	
358	 | 	fBodyAccJerk-max()-Z	 | numeric | 	1	 | 	
359	 | 	fBodyAccJerk-min()-X	 | numeric | 	1	 | 	
360	 | 	fBodyAccJerk-min()-Y	 | numeric | 	1	 | 	
361	 | 	fBodyAccJerk-min()-Z	 | numeric | 	1	 | 	
362	 | 	fBodyAccJerk-sma()	 | numeric | 	1	 | 	
363	 | 	fBodyAccJerk-energy()-X	 | numeric | 	1	 | 	
364	 | 	fBodyAccJerk-energy()-Y	 | numeric | 	1	 | 	
365	 | 	fBodyAccJerk-energy()-Z	 | numeric | 	1	 | 	
366	 | 	fBodyAccJerk-iqr()-X	 | numeric | 	1	 | 	
367	 | 	fBodyAccJerk-iqr()-Y	 | numeric | 	1	 | 	
368	 | 	fBodyAccJerk-iqr()-Z	 | numeric | 	1	 | 	
369	 | 	fBodyAccJerk-entropy()-X	 | numeric | 	1	 | 	
370	 | 	fBodyAccJerk-entropy()-Y	 | numeric | 	1	 | 	
371	 | 	fBodyAccJerk-entropy()-Z	 | numeric | 	1	 | 	
372	 | 	fBodyAccJerk-maxInds-X	 | numeric | 	1	 | 	
373	 | 	fBodyAccJerk-maxInds-Y	 | numeric | 	1	 | 	
374	 | 	fBodyAccJerk-maxInds-Z	 | numeric | 	1	 | 	
375	 | 	fBodyAccJerk-meanFreq()-X	 | numeric | 	1	 | 	
376	 | 	fBodyAccJerk-meanFreq()-Y	 | numeric | 	1	 | 	
377	 | 	fBodyAccJerk-meanFreq()-Z	 | numeric | 	1	 | 	
378	 | 	fBodyAccJerk-skewness()-X	 | numeric | 	1	 | 	
379	 | 	fBodyAccJerk-kurtosis()-X	 | numeric | 	1	 | 	
380	 | 	fBodyAccJerk-skewness()-Y	 | numeric | 	1	 | 	
381	 | 	fBodyAccJerk-kurtosis()-Y	 | numeric | 	1	 | 	
382	 | 	fBodyAccJerk-skewness()-Z	 | numeric | 	1	 | 	
383	 | 	fBodyAccJerk-kurtosis()-Z	 | numeric | 	1	 | 	
384	 | 	fBodyAccJerk-bandsEnergy()-1,8	 | numeric | 	1	 | 	
385	 | 	fBodyAccJerk-bandsEnergy()-9,16	 | numeric | 	1	 | 	
386	 | 	fBodyAccJerk-bandsEnergy()-17,24	 | numeric | 	1	 | 	
387	 | 	fBodyAccJerk-bandsEnergy()-25,32	 | numeric | 	1	 | 	
388	 | 	fBodyAccJerk-bandsEnergy()-33,40	 | numeric | 	1	 | 	
389	 | 	fBodyAccJerk-bandsEnergy()-41,48	 | numeric | 	1	 | 	
390	 | 	fBodyAccJerk-bandsEnergy()-49,56	 | numeric | 	1	 | 	
391	 | 	fBodyAccJerk-bandsEnergy()-57,64	 | numeric | 	1	 | 	
392	 | 	fBodyAccJerk-bandsEnergy()-1,16	 | numeric | 	1	 | 	
393	 | 	fBodyAccJerk-bandsEnergy()-17,32	 | numeric | 	1	 | 	
394	 | 	fBodyAccJerk-bandsEnergy()-33,48	 | numeric | 	1	 | 	
395	 | 	fBodyAccJerk-bandsEnergy()-49,64	 | numeric | 	1	 | 	
396	 | 	fBodyAccJerk-bandsEnergy()-1,24	 | numeric | 	1	 | 	
397	 | 	fBodyAccJerk-bandsEnergy()-25,48	 | numeric | 	1	 | 	
398	 | 	fBodyAccJerk-bandsEnergy()-1,8	 | numeric | 	1	 | 	
399	 | 	fBodyAccJerk-bandsEnergy()-9,16	 | numeric | 	1	 | 	
400	 | 	fBodyAccJerk-bandsEnergy()-17,24	 | numeric | 	1	 | 	
401	 | 	fBodyAccJerk-bandsEnergy()-25,32	 | numeric | 	1	 | 	
402	 | 	fBodyAccJerk-bandsEnergy()-33,40	 | numeric | 	1	 | 	
403	 | 	fBodyAccJerk-bandsEnergy()-41,48	 | numeric | 	1	 | 	
404	 | 	fBodyAccJerk-bandsEnergy()-49,56	 | numeric | 	1	 | 	
405	 | 	fBodyAccJerk-bandsEnergy()-57,64	 | numeric | 	1	 | 	
406	 | 	fBodyAccJerk-bandsEnergy()-1,16	 | numeric | 	1	 | 	
407	 | 	fBodyAccJerk-bandsEnergy()-17,32	 | numeric | 	1	 | 	
408	 | 	fBodyAccJerk-bandsEnergy()-33,48	 | numeric | 	1	 | 	
409	 | 	fBodyAccJerk-bandsEnergy()-49,64	 | numeric | 	1	 | 	
410	 | 	fBodyAccJerk-bandsEnergy()-1,24	 | numeric | 	1	 | 	
411	 | 	fBodyAccJerk-bandsEnergy()-25,48	 | numeric | 	1	 | 	
412	 | 	fBodyAccJerk-bandsEnergy()-1,8	 | numeric | 	1	 | 	
413	 | 	fBodyAccJerk-bandsEnergy()-9,16	 | numeric | 	1	 | 	
414	 | 	fBodyAccJerk-bandsEnergy()-17,24	 | numeric | 	1	 | 	
415	 | 	fBodyAccJerk-bandsEnergy()-25,32	 | numeric | 	1	 | 	
416	 | 	fBodyAccJerk-bandsEnergy()-33,40	 | numeric | 	1	 | 	
417	 | 	fBodyAccJerk-bandsEnergy()-41,48	 | numeric | 	1	 | 	
418	 | 	fBodyAccJerk-bandsEnergy()-49,56	 | numeric | 	1	 | 	
419	 | 	fBodyAccJerk-bandsEnergy()-57,64	 | numeric | 	1	 | 	
420	 | 	fBodyAccJerk-bandsEnergy()-1,16	 | numeric | 	1	 | 	
421	 | 	fBodyAccJerk-bandsEnergy()-17,32	 | numeric | 	1	 | 	
422	 | 	fBodyAccJerk-bandsEnergy()-33,48	 | numeric | 	1	 | 	
423	 | 	fBodyAccJerk-bandsEnergy()-49,64	 | numeric | 	1	 | 	
424	 | 	fBodyAccJerk-bandsEnergy()-1,24	 | numeric | 	1	 | 	
425	 | 	fBodyAccJerk-bandsEnergy()-25,48	 | numeric | 	1	 | 	
426	 | 	fBodyGyro-mean()-X	 | numeric | 	1	 | 	
427	 | 	fBodyGyro-mean()-Y	 | numeric | 	1	 | 	
428	 | 	fBodyGyro-mean()-Z	 | numeric | 	1	 | 	
429	 | 	fBodyGyro-std()-X	 | numeric | 	1	 | 	
430	 | 	fBodyGyro-std()-Y	 | numeric | 	1	 | 	
431	 | 	fBodyGyro-std()-Z	 | numeric | 	1	 | 	
432	 | 	fBodyGyro-mad()-X	 | numeric | 	1	 | 	
433	 | 	fBodyGyro-mad()-Y	 | numeric | 	1	 | 	
434	 | 	fBodyGyro-mad()-Z	 | numeric | 	1	 | 	
435	 | 	fBodyGyro-max()-X	 | numeric | 	1	 | 	
436	 | 	fBodyGyro-max()-Y	 | numeric | 	1	 | 	
437	 | 	fBodyGyro-max()-Z	 | numeric | 	1	 | 	
438	 | 	fBodyGyro-min()-X	 | numeric | 	1	 | 	
439	 | 	fBodyGyro-min()-Y	 | numeric | 	1	 | 	
440	 | 	fBodyGyro-min()-Z	 | numeric | 	1	 | 	
441	 | 	fBodyGyro-sma()	 | numeric | 	1	 | 	
442	 | 	fBodyGyro-energy()-X	 | numeric | 	1	 | 	
443	 | 	fBodyGyro-energy()-Y	 | numeric | 	1	 | 	
444	 | 	fBodyGyro-energy()-Z	 | numeric | 	1	 | 	
445	 | 	fBodyGyro-iqr()-X	 | numeric | 	1	 | 	
446	 | 	fBodyGyro-iqr()-Y	 | numeric | 	1	 | 	
447	 | 	fBodyGyro-iqr()-Z	 | numeric | 	1	 | 	
448	 | 	fBodyGyro-entropy()-X	 | numeric | 	1	 | 	
449	 | 	fBodyGyro-entropy()-Y	 | numeric | 	1	 | 	
450	 | 	fBodyGyro-entropy()-Z	 | numeric | 	1	 | 	
451	 | 	fBodyGyro-maxInds-X	 | numeric | 	1	 | 	
452	 | 	fBodyGyro-maxInds-Y	 | numeric | 	1	 | 	
453	 | 	fBodyGyro-maxInds-Z	 | numeric | 	1	 | 	
454	 | 	fBodyGyro-meanFreq()-X	 | numeric | 	1	 | 	
455	 | 	fBodyGyro-meanFreq()-Y	 | numeric | 	1	 | 	
456	 | 	fBodyGyro-meanFreq()-Z	 | numeric | 	1	 | 	
457	 | 	fBodyGyro-skewness()-X	 | numeric | 	1	 | 	
458	 | 	fBodyGyro-kurtosis()-X	 | numeric | 	1	 | 	
459	 | 	fBodyGyro-skewness()-Y	 | numeric | 	1	 | 	
460	 | 	fBodyGyro-kurtosis()-Y	 | numeric | 	1	 | 	
461	 | 	fBodyGyro-skewness()-Z	 | numeric | 	1	 | 	
462	 | 	fBodyGyro-kurtosis()-Z	 | numeric | 	1	 | 	
463	 | 	fBodyGyro-bandsEnergy()-1,8	 | numeric | 	1	 | 	
464	 | 	fBodyGyro-bandsEnergy()-9,16	 | numeric | 	1	 | 	
465	 | 	fBodyGyro-bandsEnergy()-17,24	 | numeric | 	1	 | 	
466	 | 	fBodyGyro-bandsEnergy()-25,32	 | numeric | 	1	 | 	
467	 | 	fBodyGyro-bandsEnergy()-33,40	 | numeric | 	1	 | 	
468	 | 	fBodyGyro-bandsEnergy()-41,48	 | numeric | 	1	 | 	
469	 | 	fBodyGyro-bandsEnergy()-49,56	 | numeric | 	1	 | 	
470	 | 	fBodyGyro-bandsEnergy()-57,64	 | numeric | 	1	 | 	
471	 | 	fBodyGyro-bandsEnergy()-1,16	 | numeric | 	1	 | 	
472	 | 	fBodyGyro-bandsEnergy()-17,32	 | numeric | 	1	 | 	
473	 | 	fBodyGyro-bandsEnergy()-33,48	 | numeric | 	1	 | 	
474	 | 	fBodyGyro-bandsEnergy()-49,64	 | numeric | 	1	 | 	
475	 | 	fBodyGyro-bandsEnergy()-1,24	 | numeric | 	1	 | 	
476	 | 	fBodyGyro-bandsEnergy()-25,48	 | numeric | 	1	 | 	
477	 | 	fBodyGyro-bandsEnergy()-1,8	 | numeric | 	1	 | 	
478	 | 	fBodyGyro-bandsEnergy()-9,16	 | numeric | 	1	 | 	
479	 | 	fBodyGyro-bandsEnergy()-17,24	 | numeric | 	1	 | 	
480	 | 	fBodyGyro-bandsEnergy()-25,32	 | numeric | 	1	 | 	
481	 | 	fBodyGyro-bandsEnergy()-33,40	 | numeric | 	1	 | 	
482	 | 	fBodyGyro-bandsEnergy()-41,48	 | numeric | 	1	 | 	
483	 | 	fBodyGyro-bandsEnergy()-49,56	 | numeric | 	1	 | 	
484	 | 	fBodyGyro-bandsEnergy()-57,64	 | numeric | 	1	 | 	
485	 | 	fBodyGyro-bandsEnergy()-1,16	 | numeric | 	1	 | 	
486	 | 	fBodyGyro-bandsEnergy()-17,32	 | numeric | 	1	 | 	
487	 | 	fBodyGyro-bandsEnergy()-33,48	 | numeric | 	1	 | 	
488	 | 	fBodyGyro-bandsEnergy()-49,64	 | numeric | 	1	 | 	
489	 | 	fBodyGyro-bandsEnergy()-1,24	 | numeric | 	1	 | 	
490	 | 	fBodyGyro-bandsEnergy()-25,48	 | numeric | 	1	 | 	
491	 | 	fBodyGyro-bandsEnergy()-1,8	 | numeric | 	1	 | 	
492	 | 	fBodyGyro-bandsEnergy()-9,16	 | numeric | 	1	 | 	
493	 | 	fBodyGyro-bandsEnergy()-17,24	 | numeric | 	1	 | 	
494	 | 	fBodyGyro-bandsEnergy()-25,32	 | numeric | 	1	 | 	
495	 | 	fBodyGyro-bandsEnergy()-33,40	 | numeric | 	1	 | 	
496	 | 	fBodyGyro-bandsEnergy()-41,48	 | numeric | 	1	 | 	
497	 | 	fBodyGyro-bandsEnergy()-49,56	 | numeric | 	1	 | 	
498	 | 	fBodyGyro-bandsEnergy()-57,64	 | numeric | 	1	 | 	
499	 | 	fBodyGyro-bandsEnergy()-1,16	 | numeric | 	1	 | 	
500	 | 	fBodyGyro-bandsEnergy()-17,32	 | numeric | 	1	 | 	
501	 | 	fBodyGyro-bandsEnergy()-33,48	 | numeric | 	1	 | 	
502	 | 	fBodyGyro-bandsEnergy()-49,64	 | numeric | 	1	 | 	
503	 | 	fBodyGyro-bandsEnergy()-1,24	 | numeric | 	1	 | 	
504	 | 	fBodyGyro-bandsEnergy()-25,48	 | numeric | 	1	 | 	
505	 | 	fBodyAccMag-mean()	 | numeric | 	1	 | 	
506	 | 	fBodyAccMag-std()	 | numeric | 	1	 | 	
507	 | 	fBodyAccMag-mad()	 | numeric | 	1	 | 	
508	 | 	fBodyAccMag-max()	 | numeric | 	1	 | 	
509	 | 	fBodyAccMag-min()	 | numeric | 	1	 | 	
510	 | 	fBodyAccMag-sma()	 | numeric | 	1	 | 	
511	 | 	fBodyAccMag-energy()	 | numeric | 	1	 | 	
512	 | 	fBodyAccMag-iqr()	 | numeric | 	1	 | 	
513	 | 	fBodyAccMag-entropy()	 | numeric | 	1	 | 	
514	 | 	fBodyAccMag-maxInds	 | numeric | 	1	 | 	
515	 | 	fBodyAccMag-meanFreq()	 | numeric | 	1	 | 	
516	 | 	fBodyAccMag-skewness()	 | numeric | 	1	 | 	
517	 | 	fBodyAccMag-kurtosis()	 | numeric | 	1	 | 	
518	 | 	fBodyBodyAccJerkMag-mean()	 | numeric | 	1	 | 	
519	 | 	fBodyBodyAccJerkMag-std()	 | numeric | 	1	 | 	
520	 | 	fBodyBodyAccJerkMag-mad()	 | numeric | 	1	 | 	
521	 | 	fBodyBodyAccJerkMag-max()	 | numeric | 	1	 | 	
522	 | 	fBodyBodyAccJerkMag-min()	 | numeric | 	1	 | 	
523	 | 	fBodyBodyAccJerkMag-sma()	 | numeric | 	1	 | 	
524	 | 	fBodyBodyAccJerkMag-energy()	 | numeric | 	1	 | 	
525	 | 	fBodyBodyAccJerkMag-iqr()	 | numeric | 	1	 | 	
526	 | 	fBodyBodyAccJerkMag-entropy()	 | numeric | 	1	 | 	
527	 | 	fBodyBodyAccJerkMag-maxInds	 | numeric | 	1	 | 	
528	 | 	fBodyBodyAccJerkMag-meanFreq()	 | numeric | 	1	 | 	
529	 | 	fBodyBodyAccJerkMag-skewness()	 | numeric | 	1	 | 	
530	 | 	fBodyBodyAccJerkMag-kurtosis()	 | numeric | 	1	 | 	
531	 | 	fBodyBodyGyroMag-mean()	 | numeric | 	1	 | 	
532	 | 	fBodyBodyGyroMag-std()	 | numeric | 	1	 | 	
533	 | 	fBodyBodyGyroMag-mad()	 | numeric | 	1	 | 	
534	 | 	fBodyBodyGyroMag-max()	 | numeric | 	1	 | 	
535	 | 	fBodyBodyGyroMag-min()	 | numeric | 	1	 | 	
536	 | 	fBodyBodyGyroMag-sma()	 | numeric | 	1	 | 	
537	 | 	fBodyBodyGyroMag-energy()	 | numeric | 	1	 | 	
538	 | 	fBodyBodyGyroMag-iqr()	 | numeric | 	1	 | 	
539	 | 	fBodyBodyGyroMag-entropy()	 | numeric | 	1	 | 	
540	 | 	fBodyBodyGyroMag-maxInds	 | numeric | 	1	 | 	
541	 | 	fBodyBodyGyroMag-meanFreq()	 | numeric | 	1	 | 	
542	 | 	fBodyBodyGyroMag-skewness()	 | numeric | 	1	 | 	
543	 | 	fBodyBodyGyroMag-kurtosis()	 | numeric | 	1	 | 	
544	 | 	fBodyBodyGyroJerkMag-mean()	 | numeric | 	1	 | 	
545	 | 	fBodyBodyGyroJerkMag-std()	 | numeric | 	1	 | 	
546	 | 	fBodyBodyGyroJerkMag-mad()	 | numeric | 	1	 | 	
547	 | 	fBodyBodyGyroJerkMag-max()	 | numeric | 	1	 | 	
548	 | 	fBodyBodyGyroJerkMag-min()	 | numeric | 	1	 | 	
549	 | 	fBodyBodyGyroJerkMag-sma()	 | numeric | 	1	 | 	
550	 | 	fBodyBodyGyroJerkMag-energy()	 | numeric | 	1	 | 	
551	 | 	fBodyBodyGyroJerkMag-iqr()	 | numeric | 	1	 | 	
552	 | 	fBodyBodyGyroJerkMag-entropy()	 | numeric | 	1	 | 	
553	 | 	fBodyBodyGyroJerkMag-maxInds	 | numeric | 	1	 | 	
554	 | 	fBodyBodyGyroJerkMag-meanFreq()	 | numeric | 	1	 | 	
555	 | 	fBodyBodyGyroJerkMag-skewness()	 | numeric | 	1	 | 	
556	 | 	fBodyBodyGyroJerkMag-kurtosis()	 | numeric | 	1	 | 	
557	 | 	angle(tBodyAccMean,gravity)	 | numeric | 	1	 | 	
558	 | 	angle(tBodyAccJerkMean),gravityMean)	 | numeric | 	1	 | 	
559	 | 	angle(tBodyGyroMean,gravityMean)	 | numeric | 	1	 | 	
560	 | 	angle(tBodyGyroJerkMean,gravityMean)	 | numeric | 	1	 | 	
561	 | 	angle(X,gravityMean)	 | numeric | 	1	 | 	
562	 | 	angle(Y,gravityMean)	 | numeric | 	1	 | 	
563	 | 	angle(Z,gravityMean)	 | numeric | 	1	 | 	

## VII. Reference
Anguita, D., Ghio, A., Oneto, L., Parra, X., & Reyes-Ortiz, J. L. (2012). Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. 
