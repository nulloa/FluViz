library(ggplot2)
library(gridExtra)
library(httr)
library(pbapply)
library(cdcfluview)
source("R/normalize_onset.R") # Load in normalize fn
source("R/plotgrid.R") # Load in plot fn

# Read in data
url <- "https://raw.githubusercontent.com/NLMichaud/hierarchicalSIRMods/master/currentSeasonPredictions/submittedCSVs/EW01-ISU-2017-01-16.csv?token=AFk8HboySA71l67WHVIeSBIAR7awxoLqks5Yh6RKwA%3D%3D"
dat <- read.csv(url, header=TRUE)
dat$location <- factor(dat$location,
                         levels=c("HHS Region 1","HHS Region 2","HHS Region 3",
                                  "HHS Region 4","HHS Region 5","HHS Region 6",
                                  "HHS Region 7","HHS Region 8","HHS Region 9",
                                  "HHS Region 10","US National"))

# Create Plots
plotgrid(normalize_onset(dat, nalim=.001), week="1_Normalized", ilimx=8)
plotgrid(dat, week=1, ilimx=8)


