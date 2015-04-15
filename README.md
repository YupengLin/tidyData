# TidyDataProject Cook book

## Description of data set

The size of data set is 181 rows 88 columns. There are 30 volunteers, each of volunteer containing 6 activity. 30 times 6 equals 180. Hence,
180 observations are expected. The first row is the column name. 

For column, there are 86 measurement involves mean or std. The two addtional columns indicate the index of subject(volunteers )  an activity of each volunteers. 

## Method to get the tidy data set

1 Merge two data set

There are two data set the test set and train set. I use the row-bind method to get the whole Set. 

2 Extract the Mean and Std variable

I used the regular expression to find out the index of the mean and standard deviation variable. By the index I can find the subset of the given mean and std measurement.

3 Set the acitivity names.

The activity name comes from y_train.txt and y_test.txt. By column-bind, I can assign the activity name to each row. Moreover, the activity in the original data set in 1~6, so I substitute with the more detailed name like "WALKING", 
"SITTING". The subject names are added same as activity names.

4 Variable name

By the index from step 2 (Extract the Mean and Std variable) and row-bind, we can assign the variable name for each column.

5 Getting tidy data set.

I used the group_by and summarize method in dplyr library. Because of the poor support of String operation in group_by and summarize function. I had to use the for loop to group_by every single columns. In addtion, the colname had to change to "V1" for more easily manipulation and then set back to the original name


