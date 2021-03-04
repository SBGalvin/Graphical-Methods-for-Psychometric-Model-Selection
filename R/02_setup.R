
# 00) Options -------------------------------------------------------------

set.seed(42)
options(scipen = 999,
        stringsAsFactors = FALSE)


# 01) Load Packages -------------------------------------------------------
# You will need these packages to run the project
library(eRm)     # conditional maximum likelihood estimation of the Rasch Model
library(psketti) # investigatory plots and tables for eRm generated models


# 02) Load data -----------------------------------------------------------
# this loads a data set packaged up in the psketti package
data(FakeDataPCM)  # Polytomous response data from the psketti package
data(FakeItemsPCM) # loads the item parameter for polytomous response data

# 03) Additional Data -----------------------------------------------------

r_o <- factor(LETTERS[1:4], levels = LETTERS[1:4])


