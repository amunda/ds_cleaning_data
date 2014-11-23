**Description**

This scripts tries to clean the data provided by Samsung which measures human activity using smartphones data set. We clean it up by taking mean of few of the measurement for each of the activity performed by each of the subjects

**Process**

1. This scripts first fetches all the test data by using method 'get_test_dataset'. This method creates test data set by joining test subjects data with their measurements and activity labels
2. Then it fetches all the training  data by using method 'get_train_dataset'. This method creates training data set by joining training data, subject ids and activity labels 
3. Both the methods also humanizes the labels by joining with 'activity_labels'. We use join so we didn't have to worry about dataset getting out of order on merge
4. We filter the columns which has 'mean' and 'std' in their column names by using 'select' 
5. finally, we produced our final dataset by using lapply and 'by' clause to group the data set.


**Dependencies**

* pylr
* data.table