library(ggplot2)
library(gridExtra)
library(cdcfluview)

#dat <- read.csv("EW44-ISU-2016-11-14.csv", header=TRUE)
dat <- read.csv("https://raw.githubusercontent.com/NLMichaud/hierarchicalSIRMods/master/currentSeasonPredictions/submittedCSVs/EW46-ISU-2016-11-27.csv?token=AFk8HRP8OkWvp0f3IYsY8Y3W3R5JAtaxks5YRLRWwA%3D%3D", header=TRUE)
dat$location <- factor(dat$location,
                         levels=c("HHS Region 1","HHS Region 2","HHS Region 3",
                                  "HHS Region 4","HHS Region 5","HHS Region 6",
                                  "HHS Region 7","HHS Region 8","HHS Region 9",
                                  "HHS Region 10","US National"))

# Load in plot function
source("plotgrid.R")


plotgrid(dat, wk=46, ilimax=4.5, normal=TRUE)




hey <- get_flu_data("national", NA, "ilinet")
hi  <- get_flu_data("hhs", 1:10, "ilinet")
