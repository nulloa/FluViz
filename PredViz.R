library(ggplot2)
library(gridExtra)
library(httr)
library(pbapply)
library(cdcfluview)
source("get_flu_data_update.R")
source("normalize_onset.R")

#dat <- read.csv("EW44-ISU-2016-11-14.csv", header=TRUE)
dat <- read.csv("https://raw.githubusercontent.com/NLMichaud/hierarchicalSIRMods/master/currentSeasonPredictions/submittedCSVs/EW47-ISU-2016-12-05.csv?token=AFk8HZjYB9bB1BwTbqLfzIC3rsRYHeyGks5YTtJ2wA%3D%3D", header=TRUE)
dat$location <- factor(dat$location,
                         levels=c("HHS Region 1","HHS Region 2","HHS Region 3",
                                  "HHS Region 4","HHS Region 5","HHS Region 6",
                                  "HHS Region 7","HHS Region 8","HHS Region 9",
                                  "HHS Region 10","US National"))

# Load in plot function
source("plotgrid.R")


plotgrid(normalize_onset(dat), wk="47_Normalized", ilimax=4.5)
plotgrid(dat, wk=47, ilimax=4.5)
