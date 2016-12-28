library(ggplot2)
library(gridExtra)
library(httr)
library(pbapply)
library(cdcfluview)
source("normalize_onset.R") # Load in normalize fn
source("plotgrid.R") # Load in plot fn

# Read in data
url <- "https://raw.githubusercontent.com/NLMichaud/hierarchicalSIRMods/master/currentSeasonPredictions/submittedCSVs/EW50-ISU-2016-12-27.csv?token=AFk8HTS07BUJLihbjx_XZHXudv_qK7ruks5YbDthwA%3D%3D"
dat <- read.csv(url, header=TRUE)
dat$location <- factor(dat$location,
                         levels=c("HHS Region 1","HHS Region 2","HHS Region 3",
                                  "HHS Region 4","HHS Region 5","HHS Region 6",
                                  "HHS Region 7","HHS Region 8","HHS Region 9",
                                  "HHS Region 10","US National"))

# Create Plots
plotgrid(normalize_onset(dat, nalim=.001), wk="50_Normalized", ilimax=6)
plotgrid(dat, wk=50, ilimax=6)
