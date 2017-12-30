The r code loads the relevant tables from the Samsung dataset:

- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

When loading "X_test" and "X_train," the values of "features" are used as column names. "y_test" and "y_train" are given "activity" as a name. "subject_test" and "subject_train" are given "subject" as a name.

The code then merges the tables as folows:

1. The columns of "subject_test," "y_test," and "X_test" are merged (in this order) to obtain a single data frame for all test data, which is saved in the data frame "test."
2. The same process is applied to "subject_train," "y_train," and "X_train," which are merged into the data frame "train."
3. The rows of "test" and "train" are merged to form the "all_data" data frame.

After "all_data" is obtained, the code replaces the content of the "acitivity" column, which contains the numbers 1-6, with the appropriate activity label, as provided in "activity_labels."

Then, the code extracts only the measurements on the mean and standard deviation for each measurement, and saves the result in the "mean_std_data" data frame.

Then, "mean_std_data" is grouped and summarised in order to obtain the average of each variable for each activity and each subject. The results are saved into the "mean_std_data_summary" data frame and written into the "mean_std_data_summary.txt" file.
