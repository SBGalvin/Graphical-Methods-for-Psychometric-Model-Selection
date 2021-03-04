# Session_1/Scripts/02_Good-Code-Bad-Code.R

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
## Good Code/ Bad Code
# Functions:
# rnorm()     creates a n-sized sample from a distribution with a defined mean and sd
# set.seed()  allows rnorm to generate reproducible data
# hist()      creates a histogram based on input data
# abline()    adds one or more straight lines to a plot
# plot()      default scatter plot function, generic x-y plots
# scale()     a generic function for center scaling data
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#


# 00) Set options ---------------------------------------------------------

set.seed(42)

# 01) Bad Code ------------------------------------------------------------
Xx=rnorm(100,100,15)
# BAD CODE:
# the name of the object is non-distinctive
# it also relies on using upper and lowercase of the same letter(x)
# there is no spacing around the assignment operator
# the function arguments are not named
# We do not know what the numbers are doing


# BAD CODE EXTENDED:
hist(Xx)




# 02) Good Code -----------------------------------------------------------
# rnorm() generates random sample of data with n values
# from a distribution with a mean and standard deviation


iq.sim  <-  rnorm(
  n = 1000,     # N observations
  mean = 100,  # Mean
  sd = 15      # Standard Deviation
)

# GOOD CODE?:
# names should be distinctive
# The output from the function is stored in an object named iq.sim
# We can clearly see which values are assigned to what arguments
# generates n = 1000 values, with mean = 100, sd = 15
# The argument inputs are spaced out so they can be read
# There are comments to explain what each argument is.
# Annotated in special circumstances

# Also good:
open.b5 <-  rnorm(n = 1000, mean = 37, sd = 1.6) # do not need to annotate every argument

# we can now apply other functions to x
# such as the hist() function to produce a histogram
hist(
  iq.sim,                     # input data
  main = "Example Histogram", # Plot title
  col = "steelblue",          # bar fill colour
  border = "white",           # bar border colour
  xlab = "Fake Data",         # x-axis label
  ylab = "Fake Count"         # y-axis label
)


# 03) Why does good code matter? ------------------------------------------

# Bad Code 2)
# At a small scale bad code is passable.
# However, when you have to do something a bit more complex it makes it difficult to read.
# The following code has very little explanation:
iq.norm<-scale(iq.sim, center = TRUE, scale = TRUE)
ob5.norm<-scale(open.b5, center = TRUE, scale = TRUE)
par(mfrow=c(3, 2))
hist(iq.sim)
abline(v=mean(iq.sim),col= 'red',lwd =2)
hist(open.b5)
abline(v=mean(open.b5), col = 'blue',lwd= 2)
plot(iq.sim, open.b5, pch = 19, type = "o",col=adjustcolor("black", alpha.f= .03))
abline(lm(iq.sim~open.b5),col= 'red',lwd= 2)
plot(iq.norm,ob5.norm, pch= 19, type ="o",col= adjustcolor("black", alpha.f =.03))
abline(lm(iq.norm ~ ob5.norm),col = 'blue',lwd= 2)
hist(iq.norm)
abline(v=mean(iq.norm), col='red', lwd=2)
hist(ob5.norm)
abline(v =mean(iq.norm), col ='blue', lwd=2)
par(mfrow=c(1,1))

# Not clear what part of the code is doing what
# no labels on most of the plots
# Also the plot is not itself very clear


# Good Code 2)
# z-scale data
iq.norm  <- scale(iq.sim, center = TRUE, scale = TRUE)  # z-scaled IQ data
ob5.norm <- scale(open.b5, center = TRUE, scale = TRUE) # z-scaled big 5 data

# Multiple plots:
# This plots the distributions of the raw data
# Distributions of the z-scaled data (per variable)
# Scatterplots between raw data and z-scale data
#
par(mfrow = c(3, 2))       # set plotting parameters, 3 rows, 2 columns

# Histogram plot in position 1, 1
hist(iq.sim, main = "IQ raw data", col = 'white')       # Histogram of raw IQ scores
abline(v = mean(iq.sim), col = 'red', lwd = 2)          # mean line on histogram

# Histogram plot in position 1, 2
hist(open.b5, main = "Big 5 raw data")                  # Histogram of raw Big 5 scores
abline(v = mean(open.b5), col = 'blue', lwd = 2)        # mean line on histogram

# Scatter plot in position 2, 1
plot(x = iq.sim, y = open.b5,                           # scatter plot of raw data
     pch = 19,                                          # point shape type
     col = adjustcolor("black", alpha.f= .03))          # colour adjustment of scatter points
abline(lm(open.b5~iq.sim), col= 'red', lwd = 2)         # regression line of x + y

# Scatter plot in position in 2, 2
plot(x = iq.norm, y = ob5.norm,                         # scatter plot of raw data
     pch = 19,                                          # point shape type
     col = adjustcolor("black", alpha.f= .03))          # colour adjustment of scatter points
abline(lm(iq.norm~ob5.norm), col = 'blue', lwd = 2)     # regression line of x + y

# Histogram plot in position 2,3
hist(iq.norm, main = "IQ data z-score", col = 'white')  # Histogram of z-scaled IQ scores
abline(v = mean(iq.norm), col ='red', lwd = 2)          # mean line on histogram

# Histogram plot in position 3,3
hist(ob5.norm, main = "Big 5 data z-sore")              # Histogram of raw Big 5 scores
abline(v = mean(iq.norm), col = 'blue', lwd = 2)        # mean line on histogram

par(mfrow = c(1, 1))       # reset plotting parameters, 1 row, 1 column

