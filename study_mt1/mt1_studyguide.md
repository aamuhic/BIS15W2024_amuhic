BIS 015L W24 MT1 Study Guide
=======================

+ [Load Libraries](#load-libraries)
+ [Arithmetic](#arithmetic)
+ [Types of Data](#types-of-data)
+ [Vectors and Objects](#vectors-and-objects)
+ [Data Matrices](#data-matrices)
+ [Making Data Frames](#making-data-frames)
+ [Working with Data Frames](#working-with-data-frames)

## Load Libraries ##

```
library(tidyverse) 
# in the tidyverse, column = variable, row = observations, cell = value

library(janitor)

library(skimr)
```

## Arithmetic ##

R can be used as a calculator - keep in mind order of operations!

Examples:

```
(4 * 12) / 2
(4 - 2) * 6
```

## Types of Data ##

There are 5 classes of data:
+ numeric
+ integer
+ character
+ logical
+ complex

Find out which class of data you're working with by using the `class()` function.
You can also use `is()`. For example:

```
is.integer(x)
```

To specify the type of data (i.e., as a new class of data), use the `as()` function.

```
my_integer <- as.integer(my_numeric) # specify your numeric data as integers
```

You might also encounter missing data, designated in R as NAs. Find out if you have any
NAs in your data with `is.na()` or `anyNA()`.
If you do have NAs in your data, remove them before calculating any statistics from your
data.

```
mean(x, na.rm = TRUE)
```

## Vectors and Objects ##

Store a string of values into an object (e.g., 'x')
```
x <- c(# list of numbers or characters)
```
Note: you can assign a single value to an object, not just a list of numbers.
Also keep in mind that objects should not be given the same name as functions that exist
in R.

Examples:

```
y <- c(1, 2, 3, 11, 19, 13, 99, 35)
vector <- c(1:100) # sequence of numbers from 1 to 100
week <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday,
Sunday")
```

We can do a bunch of things with these vectors. Including:

Calculate the mean

```
mean(x)
mean(x, na.rm = TRUE)
```

Calculate the median

```
median(x)
median(x, na.rm = TRUE)
```

And more (e.g., `sd(x)`, `max(x)`, `min(x)`, etc.)

You can also pull out specific elements from a vector by specifying the position within
the vector.
For example, to find Wednesday from the `week` vector above. Or to list the values in `y`
that are only greater than 5.

```
week[3]
y[y>5]
```
Or to evaluate all numerics in the `y` vector to determine which has a value of 11, or
which numerics are less than 10.

```
y==15
y<=10
```

To get rid of an object, use the `rm()` command.

## Data Matrices ##

### Assembling Data Matrices ###

Data matrices are stacked vectors arranged in a two-dimensional array.
Let's construct a data matrix from a bunch of related, but separate vectors.

```
# list of vectors before being compiled into a data matrix
Philosophers_Stone <- c(317.5, 657.1)
Chamber_of_Secrets <- c(261.9, 616.9)
Prisoner_of_Azkaban <- c(249.5, 547.1)
Goblet_of_Fire <- c(290.0, 606.8)
Order_of_the_Phoenix <- c(292.0, 647.8)
Half_Blood_Prince <- c(301.9, 632.4)
Deathly_Hallows_1 <- c(295.9, 664.3)
Deathly_Hallows_2 <- c(381.0, 960.5)
```
```
box_office <- c(Philosophers_Stone, Chamber_of_Secrets, Prisoner_of_Azkaban, 
Goblet_of_Fire, Order_of_the_Phoenix, Half_Blood_Prince, 
Deathly_Hallows_1, Deathly_Hallows_2)
# not yet a data matrix, just a list of all of the numbers found in all of the vectors
```

Arrange the values into a data matrix using the `matrix()` command.

```
harry_potter_matrix <- matrix(box_office, nrow = 8, byrow = TRUE)
# note that you can also arrange your vectors into columns instead of rows
```

### Assigning Row/Column Names ###

To assign row and column names to the matrix, you'll need to create more vectors with
each column/row name within them

```
region <- c("US", "non-US") # column names stored in vector
titles <- c("Philosophers_Stone", "Chamber_of_Secrets", "Prisoner_of_Azkaban", 
"Goblet_of_Fire", "Order_of_the_Phoenix", "Half_Blood_Prince", 
"Deathly_Hallows_1", "Deathly_Hallows_2") # row names stored in vector
```
```
colnames(harry_potter_matrix) <- region
rownames(harry_potter_matrix) <- titles
# harry_potter_matrix gets the values listed in region as column names
```

### Analyzing the Data Matrix ###

Now lets use our data matrix to do some cool stuff!

You can find the row or column totals with `rowSums()` and `colSums()`. Or row or column
means with `rowMeans()` or `colMeans`.

```
global <- rowSums(harry_potter_matrix)
# global is the vector that stores the row sums
total_earnings <- colSums(harry_potter_matrix)
```


Like with vectors, we can pull out values from our data matrix by specifying the
position.

```
harry_potter_matrix[2,1] # second row, first column
harry_potter_matrix[1:4] # first 4 values in the first column
harry_potter_matrix[ ,2] # second column
```

To calculate the mean of a specified column, for example

```
non_us_earnings <- harry_potter_matrix[ , 2]
# create a vector that stores only the values of the second column
mean(non_us_earnings)
```

### Adding Rows/Columns to the Matrix ###

You can even add these row/column totals as new rows/columns in your data matrix using
`cbind()` or `rbind()`.

```
harry_potter_matrix <- cbind(harry_potter_matrix, global)
harry_potter_matrix <- rbind(harry_potter_matrix, total_earnings)
```

## Making Data Frames ##

### Assembling Data Frames ###

Data frames are yet another way to store data in R, but it is by far the most common.
Let's see how to make one.

```
Sex <- c("male", "female", "male")
Length <- c(3.2, 3.7, 3.4)
Weight <- c(2.9, 4.0, 3.1)
```

Use the function `data.frame()` to combine and arrange the vectors into a data frame.

```
hbirds <- data.frame(Sex, Length, Weight)
```

### Exploring the Structure ###

To get some information on our data frame, there are a few functions we can use.

```
names(hbirds)     # names of the columns
dim(hbirds)       # dimensions, numbers of variables and observations
nrow(hbirds)      # number of rows/observations
ncol(hbirds)      # number of columns/variables
str(hbrids)
glimpse(hbirds)   # a favorite!
summary(hbirds)
head(hbirds)      # first n rows of the data frame
tail(hbirds)      # last n rows of the data frame
table(hbirds$Sex) # number of observations for a categorical variable
```
The `tabyl()` function from the `janitor` package is similar to the `table` function
shown above; it displays counts and percentages for each level.

```
tabyl(superhero_info, alignment) # name of data frame, name of variable
```

`skim()` is part of the `skimr` package and gives you a nice display of your data.

```
skim(msleep24)
```

It might also be helpful to view your data as a histogram if you want to check your
output.

```
hist(msleep$sleep_total_24)
```


### Naming and Renaming Variables ###

We can rename the column names/variable names to make them more conventional

```
hbirds <- data.frame(sex=Sex, length=Length, weight_g=Weight)
# new name = old name
```

Here's another way to rename columns.

```
mammals_new <- rename(mammals, "afr"="AFR", "annual_litters"="litters/year")
# frame name, "new_name"="Old name"
```

More ways to clean up our variable names:

```
mammals <- select_all(mammals, tolower) 
# change all variable names to lower case only

mammals <- select_all(mammals ~str_replace(., " ", "_"))
# replace spaces with underscores in all variable names

mammals <- clean_names(mammals)
# my favorite!
``` 

### Pulling Values from Rows/Columns ###

Selecting rows/columns in a data frame and data matrix are similar processes.

```
hbirds[1, ]  # pull from the 1st row
hbirds[ , 3] # pull from the 3rd column
```

Here's another way to select values from a column from a data frame using the `$` 
character.

```
w <- hbirds$weight_g
```

The `$` operator is also convenient for calculating column statistics in a relatively
clean manner (i.e., as opposed to storing the column values in an object first and
then calculating the mean of the object).

```
mean(hbirds$weight_g)
```

### Adding Rows and Columns to the Data Frame ###

Let's add a row to our data frame.
First we'll create a vector that stores all of the observations in our row.

```
new_bird <- c("female", 3.6, 3.9)
```

Then we'll use the `rbind()` function to bind this row to our data frame.

```
hbirds <- rbind(hbirds, new_bird)
```

We use a similar process for binding new columns to a data frame.

```
neighborhood <- c("lakewood", "brentwood", "lakewood", "scenic Heights")
hbirds <- cbind(hbirds, neighborhoods)
```

Or we can use the handy `$` to add a new column to our data frame.

```
hbirds$neighborhood <- c("lakewood", "brentwood", "lakewood", "scenic Heights")
```

### Saving and Importing Data Frames ###

If we want to save our data frame into a .csv file, we use the `write.csv()`
function.

```
write.csv(hbirds, "hbirds_data.csv", row.name = FALSE) # data frame, file name
```

Alternatively, we import data for a data frame using the `read_csv()` function.

```
hot_springs <- read_csv("hsprings_data.csv")
# or
hot_springs <- readr::read_csv("hsprings_data.csv") # readr is part of the tidyverse
# note that if the .csv file is not in your current working directory you'll need to
include an absolute or relative path to get to the file
```

## Working with Data Frames ##

Lets explore how we can analyze and manipulate our data frames.

Recall that we can specify the class of data in a column using the `as()` function.

```
hot_springs$scientist <- as.factor(hot_springs$scientist)
levels(hot_springs$scientist) # to see the categories of observations
```

### `filter()` ###

`filter()` is an extremely useful function part of the `dplyr` package (part of the 
`tidyverse`). It pulls out observations that match our specified criteria.

```
little_fish <- filter(fish, length<=100) # for data frame 'fish'
# use operators: >, >=, <, <=, !=, ==

filter(fish, lakeid=="AL")
```

`filter()` can also be used for multiple operations

```
filter(fish, length %in% c(167, 175))           # observations between 167-175
filter(fish, between(length, 167, 175))         # '                           '
filter(fish, near(radii_length_mm, 2, tol=0.2)) # near 2 w/ tolerance of 0.2

filter(fish, lakeid=="AL" & length > 350)       # must meet both criteria (and)
filter(fish, lakeid=="AL" | length > 350)       # must meet either criteria (or)

filter(xor(condition1, condition2))             # either but not both criteria
```

### `select()` ###

`select` is another critical `dplyr` function. It allows us to reduce/refocus our data
frame to only the variables we're interested in

```
fish_subset <- select(fish, "lakeid", "scalelength") # for data frame 'fish'
```

We can use `select()` to specify a range of columns (especially if you have numbered
variables).

```
select(fish, fish_id:length)
```

Or even if we want to exclude specific variables (using the - operator).

```
select(fish, -"fish_id", -"annnumber", - "length", -"radii_length_mm")
```

Or select variables that include specific key words/letters in their name.

```
select(fish, contains("length"))   # 'length' anywhere in the name
select(fish, starts_with("radii")) # 'radii' at the beginning of the name
select(fish, ends_with("id"))      # 'id' at the end of the variable name
select(fish, matches("a.+er"))     # column contains letter 'a' followed by string 'er'
# one_of() for column names that are from a group of names
```

Or select variables that belong to a specific class of data.

```
select_if(fish, is.numeric)      #select_if, not plain select
select_if(fish, ~!is.numeric(.)) # ! = 'not
```

### Pipes ###

Pipes are feed the output of one function into the input of the following function.
For example:

```
fish %>%
	select(lakeid, scalelength) %>%
	filter(lakeid=="AL")

#first we refocus our fish data, then restrict which observations we want to see
```

```
fish %>%
	select(lakeid, radii_length_mm) %>%
	filter(lakeid=="AL" | lakeid=="AR") %>%
	filter(between(radii_length_mm, 2, 4)) %>% 
	arrange(desc(radii_length_mm)) # from greatest to least
```

### `mutate()` ###

We use `mutate()` to create new columns from existing columns in the data frame.

```
fish %>% 
  mutate(length_mm = length*10) %>% 
  select(fish_id, length, length_mm)
```

We can also use `mutate()` or `mutate_all()` to clean up values in the data

```
mammals %>% 
	mutate_all(tolower)                             # make all entries lowercase
	
mammals %>%
	mutate(across(c("order", "family"), to lower)) # make specific columns lower case
```

### `if_else()` ###

We will use `if_else()` if we want to differentially mutate values within a column.

```
mammals %>%
	select(genus, species, newborn) %>%
	mutate(newborn_new = ifelse(newborn == -999.00, NA, newborn)) %>%
	arrange(newborn)
	
# create a new column where we take the -999.00 values under newborn and change them to
'NA'
```

### `summarize()` ###

`summarize()` helps us find summary statistics for a variable interest.

```
msleep %>%
	filter(bodywt>200) %>%
	summarize(mean_sleep_lg=mean(sleep_total),
		min_sleep_lg=min(sleep_total),
		max_sleep_lg=max(sleep_total),
		sd_sleep_lg=sd(sleep_total),
		total=n()) # number of observations
# to find the average sleep total (and more) for animals of specified weight
```

One statistic we might want to find is the number of distinct observations under a
variable. In that case we use `n_distinct` with the `summarize()` function

```
msleep %>%
	summarize(n_genera=n_distinct(genus)) # number of unique genera
```

Some other functions to use with `summarize()`: `first()`, `last()` for the first and
last values in a column, respectively.

### `group_by()` ###

We often pipe `group_by()` to `summarize()` to get summary statistics by value/category
(it will only work with categorical variables!).

```
msleep %>%
	group_by(vore) %>% # we are grouping by feeding ecology, a categorical variable
  	summarize(min_bodywt = min(bodywt),
            	max_bodywt = max(bodywt),
            	mean_bodywt = mean(bodywt),
            	total=n())
# will display min, max, mean for each category instead of overall values
```

Note that you'll often have to remove any NAs using `na.rm = TRUE` or `filter(!is.na())`
any time you find summary statistics.

If you need to you can also find the number of NAs per category for a variable.

```
penguins %>%
	group_by(island) %>%
	summarize(number_NAs=sum(is.na(body_mass_g)))
```

### Counts ###

We often use `count()` to see how many observations we have in a column (as a way to
combine the work of `group_by` and `summarize`).

```
penguins %>%
	count(island, sort = T)          # sort in descending order

penguins %>%
	count(island, species, sort = T) # across multiple variables
```

### `across()` ###

`across()` is helpful for calculating a statistic over multiple variables.

```
penguins %>%
	summarize(across(c(species, island, sex), n_distinct))
# find the number of distinct observations for species, island, and sex
```

Applications of `across()` become very useful when working with continuous variables.

```
penguins %>%
	summarize(across(contains("mm"), mean, na.rm=TRUE))

penguins %>%
	summarize(across(a:b, \(x) mean(x, na.rm=TRUE))     # to deal with the error
```

You can also pair `across()` with `group_by()` to see how the statistics compare between
categories.

```
penguins %>%
  group_by(sex) %>% 
  summarize(across(contains("mm"), mean, na.rm=T))
```

Remember you can also use operators, or any of the other `dplyr` operators, with
`summarize()`.

```
penguins %>%
	summarize(across(!c(species, island, sex, year), mean, na.rm = T))
# get rid of all categorical variables

penguins %>%
	summarize(across(starts_with("bill"), mean, na.rm = TRUE))
```

To summarize across all variables use `summarise_all()`.

```
penguins %>%
	summarise_all(mean, na.rm = TRUE)
```

