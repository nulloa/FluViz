library(ggplot2)
library(gridExtra)

dat <- read.csv("EW44-ISU-2016-11-14.csv", header=TRUE)
natdat <- subset(dat, location=="US National" & type=="Bin")

# Plots the probabilities of %ILL via week ahead and by region
p <- ggplot(data=subset(dat, as.numeric(as.character(bin_start_incl)) < 5 & type=="Bin" & target %in% c("1 wk ahead","2 wk ahead","3 wk ahead","4 wk ahead")), 
            aes(x=bin_start_incl, y=value)) + geom_point() + labs(x="ILI%", y="Prob")
p + facet_grid(target~location)

# Grid of plots
p1wk  <- ggplot(data=subset(dat, location=="US National" & as.numeric(as.character(bin_start_incl)) < 3 & target=="1 wk ahead"), 
            aes(x=bin_start_incl, y=value)) + geom_point() + labs(title = "1 Week Ahead", x="ILI%", y="Prob")
p2wk  <- ggplot(data=subset(dat, location=="US National" & as.numeric(as.character(bin_start_incl)) < 3 & target=="2 wk ahead"), 
               aes(x=bin_start_incl, y=value)) + geom_point() + labs(title = "2 Week Ahead", x="ILI%", y="Prob")
p3wk  <- ggplot(data=subset(dat, location=="US National" & as.numeric(as.character(bin_start_incl)) < 3 & target=="3 wk ahead"), 
               aes(x=bin_start_incl, y=value)) + geom_point() + labs(title = "3 Week Ahead", x="ILI%", y="Prob")
p4wk  <- ggplot(data=subset(dat, location=="US National" & as.numeric(as.character(bin_start_incl)) < 3 & target=="4 wk ahead"), 
               aes(x=bin_start_incl, y=value)) + geom_point() + labs(title = "4 Week Ahead", x="ILI%", y="Prob")
onst  <- ggplot(data=subset(dat, location=="US National" & target=="Season onset"), 
               aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + geom_point() + labs(title = "Season Onset", x="Week", y="Prob")
pkper <- ggplot(data=subset(dat, location=="US National" & target=="Season peak percentage"), 
               aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + geom_point() + ylim(0, .25) + labs(title = "Season Peak Percentage", x="Percent", y="Prob")
pkwk  <- ggplot(data=subset(dat, location=="US National" & target=="Season peak week"), 
               aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + geom_point() + ylim(0, 1) + labs(title = "Season Peak Week", x="Week", y="Prob")
grid.arrange(p1wk,onst,p2wk,pkper,p3wk,pkwk,p4wk, nrow=4, ncol=2)

# Plots the probabilities of %ILL by region colored by week
plot <- ggplot(data=subset(dat, as.numeric(as.character(bin_start_incl)) < 5 & target %in% c("1 wk ahead","2 wk ahead","3 wk ahead","4 wk ahead")), 
               aes(x=as.numeric(as.character(bin_start_incl)), y=value, color=target)) + geom_point() + facet_grid(~location) + labs(x="ILI%", y="Prob")
plot
