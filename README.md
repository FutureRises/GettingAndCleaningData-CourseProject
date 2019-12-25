---
title: "CourseProject README file"
author: "James Johnson"
---


#### Script leaves the following datasets in the environment:

* finalData - The final dataset that was turned in containing the means of the variables.
* allData - Dataset representing the merged training and testing data.
* meanSTDSub - subset of the allData dataset with just the mean/std variables

#### Additional Notes on script.

* The code works as long as the 'UCI HAR Dataset' folder is in the working directory with the script.

* The script requires the plyr and dplyr libraries and are loaded as part of the script.

#### Execution

1. Once libraries are loaded, the 'test' data and 'train' data are read into R separately. Extra spaces are removed and then the data is split along the remaining spaces.
They are converted into a dataframes and their columns are converted into numerics.

2. Features list is loaded into R. Numbers in the beginning and the parentheses are removed. The features are added a column names to the data set.

3. Activities and Subjects are loaded in to R and attached to datasets as addidtional columns.

4. Training and testing data sets are merged (allData)

5. Activity Names are mapped to the 'Activities' column.

6. Features that measure 'mean and 'std' are subsetted from the larger dataset. (meanSTDsUB)

7. The subset is ordered by subject and activity and the mean of each variable is taken

8. Excess varibles are cleaned up.
