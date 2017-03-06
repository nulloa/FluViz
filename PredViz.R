library(ggplot2)
library(gridExtra)
library(httr)
library(pbapply)
library(cdcfluview)
library(MMWRweek)
library(FluViz)
source("R/normalize_onset.R") # Load in normalize fn
source("R/plotgrid.R") # Load in plot fn

# Read in data
dat <- read.csv(file.choose(), header=TRUE)
dat$location <- factor(dat$location,
                         levels=c("HHS Region 1","HHS Region 2","HHS Region 3",
                                  "HHS Region 4","HHS Region 5","HHS Region 6",
                                  "HHS Region 7","HHS Region 8","HHS Region 9",
                                  "HHS Region 10","US National"))

# Create Plots
plotgrid(normalize_onset(dat, nalim=.001), ilimx=12)
plotgrid(dat, ilimx=12)


