library(ggplot2)
library(gridExtra)
library(httr)
library(pbapply)
library(cdcfluview)
source("normalize_onset.R") # Load in normalize fn
source("plotgrid.R") # Load in plot fn

#dat <- read.csv("EW44-ISU-2016-11-14.csv", header=TRUE)
dat <- read.csv("https://raw.githubusercontent.com/NLMichaud/hierarchicalSIRMods/master/currentSeasonPredictions/submittedCSVs/EW48-ISU-2016-12-12.csv?token=AFk8HQV20wboes4cSdTxk_uYPyDAlClEks5YWJ60wA%3D%3D", header=TRUE)
dat$location <- factor(dat$location,
                         levels=c("HHS Region 1","HHS Region 2","HHS Region 3",
                                  "HHS Region 4","HHS Region 5","HHS Region 6",
                                  "HHS Region 7","HHS Region 8","HHS Region 9",
                                  "HHS Region 10","US National"))

# Create Plots
plotgrid(normalize_onset(dat), wk="48_Normalized", ilimax=6)
plotgrid(dat, wk=48, ilimax=6)
