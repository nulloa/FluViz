plotgrid <- function(dat, wk, ilimax){
  
  require(ggplot2)
  require(gridExtra)
  require(cdcfluview)
  
  NatFluDat <- get_flu_data("national", NA, "ilinet")
  RegFluDat <- get_flu_data("hhs", 1:10, "ilinet")
  CFluDat <- rbind(NatFluDat,RegFluDat)
  CFluDat$REGION[CFluDat$REGION=="X"] <- "National"
  CFluDat$REGION <- as.factor(CFluDat$REGION)
  levels(CFluDat$REGION) <- c("US National", "HHS Region 1","HHS Region 10",
                              "HHS Region 2","HHS Region 3","HHS Region 4",
                              "HHS Region 5","HHS Region 6","HHS Region 7",
                              "HHS Region 8","HHS Region 9")
  
  CurrentILIPer <- c(tail(as.numeric(RegFluDat$'% WEIGHTED ILI'), n=10),tail(as.numeric(NatFluDat$'% WEIGHTED ILI'), n=1))
  # ILI Baselines for Regions 1:10, National
  ILIbaseline <- read.csv("ILIBaselines.csv")

  region <- levels(dat$location)
  sbdat <- subset(dat, as.numeric(as.character(bin_start_incl)) <= ilimax & 
                    target %in% c("1 wk ahead","2 wk ahead","3 wk ahead","4 wk ahead"))
    
  pdf(paste("PredPlots/week", wk, ".pdf", sep=""), width=18, height=12)

  for(i in 1:length(region)){
    # Plot ILI% predictions for Weeks out
    p1wk  <- ggplot(data=subset(dat, location==region[i] & as.numeric(as.character(bin_start_incl)) <= ilimax & target=="1 wk ahead"), 
                    aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + geom_point() + 
                    labs(title = "1 Week Ahead", x="ILI%", y="Prob") + geom_vline(xintercept = CurrentILIPer[i])
    
    p2wk  <- ggplot(data=subset(dat, location==region[i] & as.numeric(as.character(bin_start_incl)) <= ilimax & target=="2 wk ahead"), 
                    aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + geom_point() + 
                    labs(title = "2 Week Ahead", x="ILI%", y="Prob") + geom_vline(xintercept = CurrentILIPer[i])
    
    p3wk  <- ggplot(data=subset(dat, location==region[i] & as.numeric(as.character(bin_start_incl)) <= ilimax & target=="3 wk ahead"), 
                    aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + geom_point() + 
                    labs(title = "3 Week Ahead", x="ILI%", y="Prob") + geom_vline(xintercept = CurrentILIPer[i])
    
    p4wk  <- ggplot(data=subset(dat, location==region[i] & as.numeric(as.character(bin_start_incl)) <= ilimax & target=="4 wk ahead"), 
                    aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + geom_point() + 
                    labs(title = "4 Week Ahead", x="ILI%", y="Prob") + geom_vline(xintercept = CurrentILIPer[i])
    
    # Plot Onset Week Predictions
    onstdat <- subset(dat, location==region[i] & target=="Season onset" & type=="Bin")
    onstdat$bin_start_incl <- factor(as.factor(onstdat$bin_start_incl))
    onstdat$bin_start_incl <- factor(onstdat$bin_start_incl, levels=c(paste(c(40:52,1:20),".0",sep=""),"none"))
    levels(pkwkdat$bin_start_incl) <- paste(c(40:52,1:20),"None")
    onst  <- ggplot(data=onstdat, aes(x=bin_start_incl, y=value)) + 
        geom_point() + labs(title = "Season Onset", x="Week", y="Prob")
    
    # Plot Peak Percentage Predictions
    pkper <- ggplot(data=subset(dat, location==region[i] & target=="Season peak percentage" & type=="Bin"), 
                    aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + geom_point() + labs(title = "Season Peak Percentage", x="Percent", y="Prob")
    
    # Plot Peak Week Predictions
    pkwkdat <- subset(dat, location==region[i] & target=="Season peak week")
    pkwkdat$bin_start_incl <- factor(as.factor(pkwkdat$bin_start_incl))
    pkwkdat$bin_start_incl <- factor(pkwkdat$bin_start_incl, levels=c(paste(c(40:52,1:20),".0",sep="")))
    levels(pkwkdat$bin_start_incl) <- paste(c(40:52,1:20))
    pkwk  <- ggplot(data=pkwkdat, aes(x=bin_start_incl, y=value)) + 
      geom_point() + ylim(0, 1) + labs(title = "Season Peak Week", x="Week", y="Prob")
    
    # Plot Actual % ILI up to current week
    csub <- subset(CFluDat,REGION==region[i])
    truedat <- ggplot(data=csub,aes(x=WEEK, y=csub$'% WEIGHTED ILI')) + 
      geom_line()+geom_point()+ylab("Actual % ILI") + scale_x_continuous(breaks=csub$WEEK) +
      geom_hline(yintercept = ILIbaseline$Baselines[ILIbaseline$Region==region[i]])
    
    # Arranges various plots onto a grid
    grid.arrange(p1wk,onst,p2wk,pkper,p3wk,pkwk,p4wk,truedat, nrow=4, ncol=2, top=paste(region[i]))
  }
  
  
  # Plots the probabilities of %ILI by region colored by week
  natplot <- ggplot(data=sbdat, aes(x=as.numeric(as.character(bin_start_incl)), y=value, color=target)) +
    geom_point(size = 1) + facet_grid(location~.) + labs(x="ILI%", y="Prob", title="ILI by Region")
    
  print(natplot)
  
  dev.off()
  
}