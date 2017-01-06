plotgrid <- function(dat, week, ilimax){
  require(ggplot2)
  require(gridExtra)
  require(cdcfluview)
  require(FluSight)
  
  source("R/plotcdcdata.R")
  source("R/plotOnset.R")
  source("R/plotPeakWeek.R")
  source("R/plotPeakPer.R")
  source("R/plotWeekAhead.R")
  
  # ILI Baselines for Regions 1:10, National
  ILIbaseline <- read.csv("ILIBaselines.csv")

  region <- levels(dat$location)
    
  pdf(paste("PredPlots/week", week, ".pdf", sep=""), width=18, height=12)

  for(i in 1:length(region)){
    
    # Plot ILI% predictions for Weeks out
    p1wk <- plotWeekAhead(dat, region=region[i], wk=1)
    p2wk <- plotWeekAhead(dat, region=region[i], wk=2)
    p3wk <- plotWeekAhead(dat, region=region[i], wk=3)
    p4wk <- plotWeekAhead(dat, region=region[i], wk=4)
    
    # Plot Onset Week Predictions
    onst  <- plotOnset(dat, region[i])
    
    # Plot Peak Percentage Predictions
    pkper <- plotPeakPer(dat, region[i])
      
    # Plot Peak Week Predictions
    pkwk  <- plotPeakWeek(dat, region[i])

    # Plot Actual % ILI up to current week
    truedat <- plotcdcdata(region[i])
    
    # Arranges various plots onto a grid
    grid.arrange(p1wk,onst,p2wk,pkper,p3wk,pkwk,p4wk,truedat, nrow=4, ncol=2, top=paste(region[i]))
  }
  
  
  # Plots the probabilities of %ILI by region colored by week
  sbdat <- subset(dat, as.numeric(as.character(bin_start_incl)) <= ilimax & 
                    target %in% c("1 wk ahead","2 wk ahead","3 wk ahead","4 wk ahead"))
  
  natplot <- ggplot(data=sbdat, aes(x=as.numeric(as.character(bin_start_incl)), y=value, color=target)) +
    geom_point(size = 1) + facet_grid(location~.) + labs(x="ILI%", y="Prob", title="ILI by Region")
    
  print(natplot)
  
  dev.off()
  
}