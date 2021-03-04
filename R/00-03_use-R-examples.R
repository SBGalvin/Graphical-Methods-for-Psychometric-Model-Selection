
# Example 1: Comments -----------------------------------------------------

# This is commented out, it will not run:
# x <- c(1, 2, 3, 4, 5)  # a numeric vector
# y

# This is NOT commented out, and it will run:
y   <- c(6, 7, 8, 9, 10) # a numeric vector
y # this should print to the output console


# Example 2 Getting Help --------------------------------------------------

# these will load the help document for a function:
?c        # concatenate things
?head     # help for the head() function
?mean     # help for the mean function
?sd       # help for the standard deviation function
?round    # rounds numbers
?paste0   # pastes things together
?rnorm    # produces a random sample
?hist     # produces histogram of input list
?summary  # summary values


# Example 3 Assignment ---------------------------------------------------

# if we run a function without assignment it will not save in the environment
rnorm(n = 10, mean = 100, sd = 15)        # outputs directly to the console

# we need to store the output in an object, so we can do things with it
x <- rnorm(n = 1000, mean = 100, sd = 15) # sample 1000 values from a normal distribution

summary(x)                                # print a summary of x to the console
hist(x, col = "steelblue")                # make a histogram of x


# Example 4 Applying functions to Objects ---------------------------------
head(x) # we can print directly to the console
x_hat    <- mean(x)   # mean
x_sd     <- sd(x)     # standard deviation

# we can perform functions inside functions
cat(paste0("Mean of x: ",
             round(x_hat, 2),
             "\n",
             "SD of x: ", round(x_sd, 2)))
