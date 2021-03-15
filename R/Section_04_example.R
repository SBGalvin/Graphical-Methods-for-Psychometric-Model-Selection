
# Notes -------------------------------------------------------------------
# First run R/01_package-installs.R to install all necessary R packages
#
# Example from slides section (4) in talk
# psketti supplies a simulated data set:
#          for help doc see
#          ?FakePCMData
#
# (0) Convert PCM data to dichotomous data for scoring example
# (1) Estimate a Rasch model, psketti plots
# (2) Estimate a PCM, psketti plots


# Load Packages -----------------------------------------------------------
library(tidyverse)                                                 # install this if not already installed !!!
library(eRm)                                                       # install this if not already installed !!!
library(psketti)                                                   # install this if not already installed !!!

# Data --------------------------------------------------------------------
data("FakePCMData")                                                # Load Fake pcm Data from psketti
F2           <- FakePCMData                                        # copy fake data to new object
rownames(F2) <- F2$ID                                              # Id column to row names (eRm will throw error if not)
F2$ID        <- NULL                                               # Drop the ID column


# Dichotomized dataset (for example only)
F3 <- FakePCMData %>%                                              # input data

  pivot_longer(cols = -ID,                                         # Select all EXCEPT this column for pivot
               names_to = "Item",                                  # New Item column name
               values_to = "Response") %>%                         # New Value column name
  mutate(R2 = ifelse(Response == 3, 1, 0)) %>%                     # Dichotomize responses
  mutate(Response = sprintf(fmt = "%02d", Response))               # convert to padded character

# prepare Dichotomized data for eRm Rasch estimation
F4 <- F3 %>%
  select(ID, Item, R2) %>%                                         # select relevant columns
  pivot_wider(names_from = "Item", values_from = "R2") %>%         # from LONG to WIDE format
  as.data.frame() %>%                                              # convert to dataframe
  column_to_rownames(var = "ID")                                   # ID column to row names


# prepare factor variable for distractor analysis
r_o <- factor(as.character(sort(unique(F3$Response))),             # Response options as factor
              levels = as.character(sort(unique(F3$Response))),    # factor levels
              ordered = TRUE)                                      # ordered factor


# 01) Dichotomous Rasch Model ---------------------------------------------

F_dRM <- RM(F4)                                                    # estimate dRM


F_dRM_lr <- LRtest(F_dRM, splitcr = "median")                      # Andersen Likelihood Ratio Test
F_dRM_lr

F_dRM_psk <- pskettify(eRm.obj = F_dRM)                            # pskettify your data

# Show all Item IRF (no empirical values)
psketto_simple(x = F_dRM_psk,                                      # pskettified data
               all.item = TRUE,                                    # show all item IRF
               item.label = TRUE) +                                # Show item labels
  theme_minimal()                                                  # use ggplot2 theme

# Rasch IRF with empirical values
i07_fdRM <- psketto(F_dRM_psk,                                     # pskettified object
                    item = "i07",                                  # Item Name
                    item.label = "i07")                            # Item Label for print

f_dRM_ifit <- item_fit_table(eRm.obj = F_dRM)                      # Item Fit table
f_dRM_ifit[f_dRM_ifit$Item == "i07", ]                             # show only item i07 ## out fit T is high, MSQ is low(ish)

f_dRM_msq  <- psketti_msq(x = f_dRM_ifit)                          # MSQ outfit/infit plot
f_dRM_msq

# Class-Interval Table
f_dRM_tab <- tabliatelle(x = F3,                                   # data object
                         eRm.obj = F_dRM,                          # Rasch model object
                         ID = "ID",                                # ID column
                         Item = "Item",                            # Item column
                         K = "Response",                           # "K" (categories) column
                         response_options = r_o)                   # Response options factor object



tab_x <- f_dRM_tab$Proportions.table                               # extract the proportions table
tab_x[tab_x$Item == "i07",]                                        # show only item i07

# Distractor plot
F3_distractors <- psketti_distractor(x = F3,                       # data
                                     ID = "ID",                    # ID column
                                     Item = "Item",                # Item Column
                                     K = "Response",               # "K" (categories) column
                                     eRm.obj = F_dRM,              # Rasch model object
                                     response_options = r_o,       # response option factor object
                                     ncut = 10)                    # number of cuts for the x axis

F3_distractors$Plot.List[['i07']][[1]]                             # show distractor plot for item i07

# 02) Partial Credit Model ------------------------------------------------
# Prepare PCM data for Rasch Model
f_PCM    <- PCM(F2)                                                # estimate Rasch PCM

f_PCM_lr <- LRtest(f_PCM, splitcr = "median")                      # Andersen Likelihood Ratio Test
f_PCM_lr                                                           # LR test output

f_PCM_ifit <- item_fit_table(eRm.obj = f_PCM)                      # item fit table
f_PCM_ifit[f_PCM_ifit$Item == "i07",]                              # show ony item i07

f_PCM_msq  <- psketti_msq(x = f_PCM_ifit)                          # MSQ plot
f_PCM_msq

f_PCM_psk <- pskettify(eRm.obj = f_PCM)                            # pskettify eRm PCM object

# Rasch PCM IRF (no empirical values)
i07_fPCM <- psketto(f_PCM_psk,                                     # pskettified object
                    item = "i07",                                  # Item Name
                    item.label = "i07",                            # Item Label for print
                    empICC = FALSE,                                # Turn off empirical ICC
                    empPoints = FALSE)                             # Turn off empirical Points

i07_fPCM                                                           # print to plot viewer


# Rasch PCM IRF (with empirical values and faceted)
i07_fPCM_faceted <- psketto(f_PCM_psk,                             # pskettified object
                            item = "i07",                          # Item Name
                            item.label = "i07",                    # Item Label for print
                            facet_curves = TRUE)                   # Facet the plot

i07_fPCM_faceted                                                   # print to plot viewer

