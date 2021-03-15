
# setup -------------------------------------------------------------------
options(scipen = 999,
        stringsAsFactors = FALSE) # just in case

# load required packages
library(tidyverse)     # useful for data preparation/analysis/plots
library(eRm)           # CML estimation of Rasch Models
library(psketti)       # Investigatory Rasch Model plots


# data --------------------------------------------------------------------

data("FakeData")                  # load data bundled in psketti

# Create an Item x Person dataframe: reshape() restructures data from Long to Wide
Fake_Data_scores <- reshape(FakeData[, c("ID", "Item", "X")],   # subset data
                            timevar = "Item",                   # grouping variale
                            idvar = "ID",                       # ID variable
                            direction = "wide")                 # direction to reshape to
# for eRm new names
names(Fake_Data_scores) <- c("ID",
                             paste0("i",
                                    sprintf(fmt  = "%02d", 1:23)))

row.names(Fake_Data_scores) <- Fake_Data_scores$ID  # copy ID column as the row name
Fake_Data_scores$ID         <- NULL                 # remove id column




# Describe the Raw Score --------------------------------------------------
RawScore <- rowSums(Fake_Data_scores)              # raw scores

RawScore_Sumary <- tibble(N = length(RawScore),    # Count
                          Mean = mean(RawScore),   # Mean
                          StDev = sd(RawScore),    # SD
                          Min = min(RawScore),     # Min
                          Max = max(RawScore))     # Max

RawScore_Sumary <- round(RawScore_Sumary, 2)       # round the tibble

RawScore_Sumary                                    # print to console

hist(x = RawScore,                                 # input object
     main = "Histogram of Raw Scores",             # plot title
     col = "steelblue")                            # fill colour



# Rasch Analysis ----------------------------------------------------------
fake_rm   <- RM(Fake_Data_scores)       # estimate dichotomous Rasch Model


# Andersen Likelihood ratio test, compare model estimates between to subsets, using median split
fake_lr <- LRtest(fake_rm, splitcr = "median") # Global Goodness of Fit test

summary(fake_lr)                               # view full summary
fake_lr                                        # view abbreviated output: Chi-square and p value

## p> .05 mean there is a model fit using the LR test split criteria

# plot goodness of fit test: plots estimates from LR subsets ~~~~~~

subset_cor <- round(cor(fake_lr$betalist$high *-1,     # correlation between beta estimates
                        fake_lr$betalist$high *-1), 2)

plotGOF(fake_lr,                                                          # LRtest object
        main = paste0("LR test. Beta Correlation between subsets: ",      # Main plot label
                      subset_cor),                                        # rounded correlations
        xlab = "Score <= Median",                                         # x axis label
        ylab = "Score > Median")                                          # y axis label

# see ?plotGOF for help

plotjointICC(fake_rm, legend = FALSE)  # plot theoretical ICC for all items

# Person-Item Map ---------------------------------------------------------

# the PI map shows the overlap between the Item and Locations and the
# Sample ability locations
plotPImap(fake_rm)

# Density plot ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Density plot shows the overlap in distribution  between people and items
ppar        <- person.parameter(fake_rm) # compute estimated person parameters
RaschScores <- ppar$thetapar$NAgroup1    # extract estimated person parameters


tibble(Type = c(rep("Theta", length(RaschScores)),rep( "Beta",  length( coef( fake_rm ) ) ) ),
       Value = c(RaschScores, -coef(fake_rm))) %>%
  ggplot(aes(x = Value, fill = Type, colour = Type))+
  geom_density(alpha = .6)+
  scale_fill_manual(values = c("steelblue", "tomato"), labels = c("Item", "People"), name = "")+
  scale_colour_manual(values = c("steelblue", "tomato"), labels = c("Item", "People"), name = "")+
  xlab(expression(theta))+
  theme_minimal()+
  theme(legend.position = "bottom")


# psketti -----------------------------------------------------------------
# pskettify data
psk_data <- pskettify(eRm.obj = fake_rm,   # output object from eRm::RM()
                      conf.level = .95,    # select confidence level for empirical points
                      Theta.lwr = -6,      # select upper limit to ability range
                      Theta.upr = 6)       # set lower limit to ability range

# Item i01 plot ~~~~~~
# plot ICC for one item
psk_1_present <- psketto(psk_data,           # input psketttified data
                         style = "present",  # plot style
                         item = "i01",       # item name
                         item.label = "i01") # item label for plot, can be same as name

psk_1_present # print plot

psk_1_print <- psketto(psk_data,           # input psketttified data
                       style = "print",    # plot style: greyscale
                       item = "i01",       # item name
                       item.label = "i01") # item label for plot, can be same as name

psk_1_print

# Multiple plots ~~~~~~
psk_IRF <- psketti(psk_data)       # plot with default settings

psk_IRF                            # will print instructions to the console

psk_IRF$Plot.List[['i02']][[1]]    # show plot


# Item Fit Table ----------------------------------------------------------
itemFit_psk <- item_fit_table(fake_rm)   # extract item fit statistics

itemFit_psk                              # print item fit to console


# write output file/ table of data
readr::write_csv(itemFit_psk,                   # object name
                 "data/drm-item-fit-stats.csv") # filepath/name/extension

# MSQ plot
psk_msq <- psketti_msq(x = itemFit_psk)   # generates a plot of MSQ values

psk_msq                                   # print plot


# Class-Interval table ----------------------------------------------------
# Investigate to see if any items need rescoring
# factor for response options
r_o      <- factor(sort(unique(FakeData$K)), levels = sort(unique(FakeData$K)), ordered = TRUE)


tlt_data <- tabliatelle(x = FakeData,           # input data
                        ID = "ID",              # ID column
                        Item = "Item",          # Item column
                        K = "K",                # Category column
                        response_options = r_o, # response options factor object
                        eRm.obj = fake_rm)      # eRm::RM() output object

tlt_data # print to console

tlt_data$Frequency.table    # show raw frequencies
tlt_data$Proportions.table  # show un-rounded proportions

# Distractor Curves -------------------------------------------------------

# multiple plots
spag_plot <- psketti_distractor(ID = "ID",              # set ID column
                                Item = "Item",          # set Item column
                                K= "K",                 # Set resp categories
                                x = FakeData,           # select data
                                eRm.obj = fake_rm,      # select eRm object
                                response_options = r_o, # set resp options
                                p.style = "present")    # set plotting style


spag_plot$Plot.List[['i01']][[1]] # plot item 1


# Plot with custom colours
new_colours <- RColorBrewer::brewer.pal(5, "Dark2")

spag_plot2 <- psketti_distractor(ID = "ID",                           # set ID column
                                 Item = "Item",                       # set Item column
                                 K= "K",                              # Set resp categories
                                 x = FakeData,                        # select data
                                 eRm.obj = fake_rm,                   # select eRm object
                                 response_options = r_o,              # set resp options
                                 p.style = "present",                 # set plotting style
                                 distractor_colours = new_colours)    # custom colours

spg_i1 <- spag_plot2$Plot.List[['i01']][[1]] # plot item 2

# Score Report ------------------------------------------------------------

K_opt <- factor(LETTERS[1:5], levels = LETTERS[1:5], ordered = TRUE)
score_report <- ingrediente(x = FakeData,        # data
                            Item = "Item",       # Item column
                            ID = "ID",           # ID column
                            Score = "X",         # Score Column (binary)
                            K = "K",             # Category column
                            K_options = K_opt,   # category options factor object
                            Index = "Index")     # Item presentation order column

# show score report for values with a total score <= 1
score_report[score_report$total_score <= 1, ]
