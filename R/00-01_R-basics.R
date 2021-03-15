# Session_1/Scripts/01_Using_R.R

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# This script reflects the material presented in S-01_R-01
# Basic Functions and Operations
# Operators
#   # https://www.datamentor.io/r-programming/operator/

# 00) Comments
# 01) Arithmetic
# 02) Variable Assignment
# 03) Functions
# 04) Data Types
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#




# 00) Comments ------------------------------------------------------------
# R we can insert a comment for many reasons:
# We a wish to explain what a code chunk is doing to give ourselves
#or a third party a signpost

# We may want to put extra information like a filepath in the script
# We may want to block some code from executing
# To insert a comment, start a line off with the '#' symbol
# everything to the right of the '#' will not run

# This code will run
x <- 22/2 *100
x

# This code will not run
#x2 <- 33/3*100
#x2

x3 <- 44/4*100 # this code will run
#x3 # This code will not run
# what is the value of x3?
# Answer:



# 01) Relational and Logical Operators ------------------------------------
# Relational Operators check a the relation between two elements and return TRUE or FALSE
1 == 1              # TRUE: 1 is equal to 1
3 > 1               # TRUE: 3 is greater than 1
2.5 >= 2.0          # TRUE: 2.5 is at least as great as 2.0
2 == 3              # FALSE : 2 is equal to 3?
10 == 1000^(1/2)    # FALSE: 10 is equal to the square root of 1000 (100)

# Logical operators are used to carry out Boolean operations
# !         # Logical NOT negating relational operator
2 != 3      # False
# &         # Element-wise logical AND can examine an array
3&3
# &&        # Logical AND examines only the first element of the operands resulting into a single length logical vector.
# |         # Element-wise logical OR can examine an array
# ||        # Logical OR examines only the first element of the operands resulting into a single length logical vector.

# Sub-setting operators
# $     used for sub-setting a nested object, ie taking only one column from a dataframe

# 02) Arithmetic ----------------------------------------------------------
# Computer languages have fairly good calculator functions. In R these take
# the form of these arithmetic operators:
# +    addition
# -    subtraction
# /    division
# *    multiplication
# ^    exponent
# %%   Modulus for remainder division
# %/%  Integer division
# Addition and subtraction

1 + 2  # = 3
10 - 5 # =5

# multiplication and division
10 * 2 # = 20
10/2   # = 5

# exponents and roots
10^2  # = 100
10^3  # = 1000

100^(1/2)   # square root = 10
1000^(1/3)  # cubic root = 10

# BOMDAS/ PEMDAS
# R obeys BOMDAS/PEMDAS
( (3*4) / ( 9^(1/2) ) ) *2  # generally use parentheses to segregate sections
3*4/9^(1/2)*2               # will also work without parentheses



# 03) Variable assignment -------------------------------------------------
# We can use object assignment to save individual values, data frames, plots, or tables as objects
# This is done using an assignment operator:
# =       # As a rule, avoid sing this for variable assignment
# <-      # This is the preferred assignment operator in R
# ->      # only used in specific circumstances

# ALWAYS put a white space around your assignment operator e.g. x <- "value"
# Best practice is to use <- or ->, leaving  =  as a state setting for function arguments
# eg options(StringAsFactor = FALSE)

# Objects cannot use existing namespaces for objects (eg functions)
# cannot use T, or F these are used for boolean operations
# cannot use t as this is the t() function
# cannot use c as this is the c() function

# output of arithmetic can be stored as objects
# output of functions can be stored as objects

# run these lines, the answer should be 8
a <- 3
4 -> b
d = 9
e <- 1/2
f <- 2

# replace arithmetic with objects
answer <- ( (a*b) / ( d^(e) ) ) *f

answer # result


# 04) Functions -----------------------------------------------------------
# functions do a lot of the heavy lifting for you so you don't have to manually perform
# a calculation for the mean, or some kind of object alteration

# the first function we learn is the c() function
# c() is short for concatenate, it concatenates a series of
# values together
# to bring up the help documentation for any function type ? followed by the function name:
?c
# c() will combine the arguments inside it's parentheses into a single object:
c(1, 2, 3, 4, 5)

# Each of the argument is separated by a comma
# Many R functions require values to be concatenated BEFORE they
# can be inserted into a function

# we can use the mean() or median() functions to produce an average value from these numbers
mean(c(1, 2, 3, 4, 5))

median(c(1, 2, 3, 4, 5))

# You can also store the output of function in an object:
# We use the c() function to concatenate a list of values and
# used the '<-' assignment operator to store the values in x1
x1  <-  c(1, 2, 3, 4, 5)
# run the variable name to print the values to the console
x1

# now we can calculate our mean and median on the object x1
mean(x1)
median(x1)

# we can also assign the output of mean and median to new objects
x1_mean   <- mean(x1)
x1_median <- median(x1)

# x1 is a vector, a simple object where all the data are of the same kind
# we can check its type using typeof()
typeof(x1) # "double" which is double precision floating point

# we can convert the type of data using as.intger()
x1_int <- as.integer(x1)

# or we could convert x1 to a character type
x1_character <- as.character(x1)
# now if we try to do arithmetic with our new object we can't
mean(x1_character)
# R console returns an error:
# [1] NA
# Warning message:
#   In mean.default(x1_character) :
#   argument is not numeric or logical: returning NA

# We can double check to see if our object is numeric:
is.numeric(x1_character) # this will return FALSE


# We may have a value in our object that is not recognised as a number (NaN) or the value
# may be missing (NA)
x2 <- c(1, 2, NaN, 4, 5)
typeof(x2)                # double

x3 <- c(1, NA, 3, 4, 5)
typeof(x3)                # "double"

# If we try to run an arithmetic function on x1 or x3 R will return an error
mean(x2) # returns NaN
mean(x3) # returns NA

# We can use another argument to the mean function that will
# perform mean while ignoring missing values
mean(x2, na.rm = TRUE)
mean(x3, na.rm = TRUE)



# 05) Combining Vectors ---------------------------------------------------

# Vectors can also be called lists
# however, storing all of our values for experiments etc. in multiple
# unconnected lists makes things difficult
# instead, we can combine lists into many new formats:
# nested lists
# matrices
# dataframes
# for now we will focus on data frames using the data.frame() family of functions
# A dataframe is a special list of lists similar to a spread sheet
# data frames can store many different kinds of data

dataframe_1 <- data.frame(
  Column_1 = c(1, 2, 3, 4, 5),
  Column_2 = c(6, 7, 8 ,9, 10)
)

typeof(dataframe_1) # "list"
str(dataframe_1)
# returns:
# 'data.frame':	5 obs. of  2 variables:
#   $ Column_1: num  1 2 3 4 5
#   $ Column_2: num  6 7 8 9 10

# We can access individual columns using the $ operator like so:
dataframe_1$Column_1

# we can perform arithmetic operations on a column
mean(dataframe_1$Column_2) # 8


# we can perform an element wise operation to compare
# two columns
dataframe_1$Column_1 == dataframe_1$Column_2
# returns:
# [1] FALSE FALSE FALSE FALSE FALSE

# we can perform element-wise arithmetic operations and assign the results to a new column
dataframe_1$Column_3 <- dataframe_1$Column_1 * dataframe_1$Column_2

# dataframe_1 now has 3 columns
str(dataframe_1)
# 'data.frame':	5 obs. of  3 variables:
#   $ Column_1: num  1 2 3 4 5
#   $ Column_2: num  6 7 8 9 10
#   $ Column_3: num  6 14 24 36 50

# there are special functions that take dataframes as an argument and
# returns an output:
summary(dataframe_1)

# We can also subset a dataframe using square bracket notation
# square brackets are called like so:

# dataframe[ROWbumber, COLUMNnumber]
# by either calling the column by index (position) number
dataframe_1[, 1]
# or by calling the column by its name:
dataframe_1[,"Column_1"]

# if we wanted the first row
dataframe_1[1,]
# Column_1 Column_2 Column_3
# 1        1        6        6

# if we want the first row and second column
dataframe_1[1, 2]
# [1] 6

# Or if we wanted to select rows that match a criterion,
# lets say we only want rows where the value in
# column 1 is equal to or greater than 2
dataframe_1[dataframe_1$Column_1 >= 2, ]
# here we have excluded the entire first row:
# Column_1 Column_2 Column_3
# 2        2        7       14
# 3        3        8       24
# 4        4        9       36
# 5        5       10       50

# Reading in local data into a dataframe
# you can use the read.csv function to read in a csv file

fake_apm <- read.csv("data/APM-Digit-Span-Fake-Data.csv")
is.data.frame(fake_apm)  # is the object a data frame?
str(fake_apm)            # what is the dataframe structure

# What can you do with a dataframe?
# we can subset the columns that we are interested in
fake_apm_subset <- fake_apm[, c("ID", "DSF", "II_total_Score")]        # subset the dataframe by column name

# perform a correlation
DSF_Score_r <- with(fake_apm_subset,                                   # use with to use data set in the cor() function
                    cor(DSF, II_total_Score))                          # correlate X and Y

# highlight the following lines together, then run, to plot the whole plot in one go:
# generate a scatter plot:
with(fake_apm_subset,                                                  # using with() you can specifiy a data set to use
     plot(x = DSF, y = II_total_Score,                                 # plot x and y
          pch = 19,                                                    # point shape
          frame = FALSE,                                               # remove outer plot border
          main = paste0("XY Correlation =", round(DSF_Score_r, 3))))   # Plot title
abline(lm(II_total_Score~DSF, data = fake_apm_subset), col = "blue")   # Regression line using lm()
