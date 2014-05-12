Data Cleaning - Smartphone Activity Recognition
========================================================

The original dataset is borrowed from the UCI Human Activity Using Smartphones project (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The dataset is for activity recognition (walking, walking upstairs, walking downstairs, sitting, standing, and laying) from smartphone low level sensor data.

The 'run_analysis.R' script contains five function calls that clean up the original dataset in various ways (See deatils in the Functions section below).

## File Structure Requirement
To call the functions in the run_analysis.R script, the data Human Activity Recognition Using Smartphone Dataset (the extracted 'HCI HAR Dataset' folder) should be located in the same directory as the 'run_analysis.R' file.

e.g., Within the project folder, the following file structure should be kept:
- run_analysis.R
- [HCI Har Dataset]
<dd>-- activity_labels.txt
<dd>-- feactures_info.txt
<dd>-- features.txt
<dd>-- README.txt
<dd>-- [test]         
<dd>-- [train]       
   
The compressed dataset can be downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Function Call

To obtain the submitted tidy data set, users need to follow the following two steps:
<ol>
<li> source the R file: <font color="blue">source("run_analysis.R")</font></li>
<li> call the AvgMerge function: <font color="blue">AvgMerge()</font></li>
</ol>
<font color="blue">AvgMerge.txt</font> is the tidy dataset that is submitted for the project.<br>
[Caution: Running the function call can take a couple of minutes.]

### Included Variables

A total of 68 variables are included in the submitted tidy data set. They are the mean and standard deviation values of the raw accelerometer and gyroscope 3-axial row signals. Only the variables of mean() and std() are included and the weighted average of the frequency components (e.g., meanFreq()) is not included in the final data set. For detailed description regarding variables, see the Variables in the Tidy Data Set section in the codebook.md file.

## Functions
The code includes five function calls that clean the original dataset in different ways:

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
