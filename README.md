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
<li> call the avgMerge function: <font color="blue">avgMerge()</font></li>
</ol>
Among the generated text files, <font color="blue">avgMerge.txt</font> is the target tidy dataset.<br>
[Caution: Running the function call can take a couple of minutes.]

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

