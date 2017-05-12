# Code Structure

* Load txt files into R
* X_train/test files are named according to the features files
* Regular expression is used to filter for col names having std and mean
* used grep with ignore.case = TRUE to make sure we do not miss anything becuase of the cases
* Added activity using inner join
* finally 'gathered' all the variables under 'Movement' under one variable
* saved tidy data containing mean after grouping the data by subject,activity,movement
