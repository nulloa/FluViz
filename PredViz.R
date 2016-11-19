library(ggplot2)
library(gridExtra)

#dat <- read.csv("EW44-ISU-2016-11-14.csv", header=TRUE)
dat <- read.csv("https://raw.githubusercontent.com/NLMichaud/hierarchicalSIRMods/master/currentSeasonPredictions/submittedCSVs/EW43-ISU-2016-11-07.csv?token=AFk8HZWP_L5HeKKUF7S0jDnIPXBIpHWiks5YOf6qwA%3D%3D", header=TRUE)
dat$location <- factor(dat$location,
                         levels=c("HHS Region 1","HHS Region 2","HHS Region 3",
                                  "HHS Region 4","HHS Region 5","HHS Region 6",
                                  "HHS Region 7","HHS Region 8","HHS Region 9",
                                  "HHS Region 10","US National"))


pdf("plots.pdf",width=12, height=12)


# Grid of plots for a specific region
region <- levels(dat$location)

for(i in 1:length(region)){
  p1wk  <- ggplot(data=subset(dat, location==region[i] & as.numeric(as.character(bin_start_incl)) < 3 & target=="1 wk ahead"), 
                  aes(x=bin_start_incl, y=value)) + geom_point() + labs(title = "1 Week Ahead", x="ILI%", y="Prob")
  p2wk  <- ggplot(data=subset(dat, location==region[i] & as.numeric(as.character(bin_start_incl)) < 3 & target=="2 wk ahead"), 
                  aes(x=bin_start_incl, y=value)) + geom_point() + labs(title = "2 Week Ahead", x="ILI%", y="Prob")
  p3wk  <- ggplot(data=subset(dat, location==region[i] & as.numeric(as.character(bin_start_incl)) < 3 & target=="3 wk ahead"), 
                  aes(x=bin_start_incl, y=value)) + geom_point() + labs(title = "3 Week Ahead", x="ILI%", y="Prob")
  p4wk  <- ggplot(data=subset(dat, location==region[i] & as.numeric(as.character(bin_start_incl)) < 3 & target=="4 wk ahead"), 
                  aes(x=bin_start_incl, y=value)) + geom_point() + labs(title = "4 Week Ahead", x="ILI%", y="Prob")
  onstdat <- subset(dat, location==region[i] & target=="Season onset")
  onstdat$bin_start_incl <- factor(onstdat$bin_start_incl, levels=paste(c(40:52,1:20)))
  onst  <- ggplot(data=onstdat, aes(x=bin_start_incl, y=value)) + 
    geom_point() + labs(title = "Season Onset", x="Week", y="Prob")
  pkper <- ggplot(data=subset(dat, location==region[i] & target=="Season peak percentage"), 
                  aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + geom_point() + ylim(0, .25) + labs(title = "Season Peak Percentage", x="Percent", y="Prob")
  pkwkdat <- subset(dat, location==region[i] & target=="Season peak week")
  pkwkdat$bin_start_incl <- factor(pkwkdat$bin_start_incl, levels=paste(c(40:52,1:20)))
  pkwk  <- ggplot(data=pkwkdat, aes(x=bin_start_incl, y=value)) + 
    geom_point() + ylim(0, 1) + labs(title = "Season Peak Week", x="Week", y="Prob")
  grid.arrange(p1wk,onst,p2wk,pkper,p3wk,pkwk,p4wk, nrow=4, ncol=2, top=paste(region[i]))
}












# Plots the probabilities of %ILI by region colored by week
sbdat <- subset(dat, as.numeric(as.character(bin_start_incl)) < 4 & 
                  target %in% c("1 wk ahead","2 wk ahead","3 wk ahead","4 wk ahead"))
ggplot(data=sbdat, aes(x=as.numeric(as.character(bin_start_incl)), y=value, color=target)) + 
  geom_point(size = 1) + facet_grid(location~.) + labs(x="ILI%", y="Prob", title="ILI by Region")
dev.off()









# Not Really Necessary
# Plots the probabilities of %ILL via week ahead and by region
#p <- ggplot(data=subset(dat, as.numeric(as.character(bin_start_incl)) < 5 & type=="Bin" & target %in% c("1 wk ahead","2 wk ahead","3 wk ahead","4 wk ahead")), 
#            aes(x=bin_start_incl, y=value)) + geom_point() + labs(x="ILI%", y="Prob")
#p + facet_grid(target~location)
