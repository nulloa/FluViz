plotgrid <- function(dat, wk, ilimax, normal=FALSE){
  
  require(ggplot2)
  require(gridExtra)
  #require(cdcfluview)
  
  region <- levels(dat$location)
  sbdat <- subset(dat, as.numeric(as.character(bin_start_incl)) <= ilimax & 
                    target %in% c("1 wk ahead","2 wk ahead","3 wk ahead","4 wk ahead"))
    
  pdf(paste("PredPlots/week", wk, ".pdf", sep=""), width=18, height=12)

  for(i in 1:length(region)){
    p1wk  <- ggplot(data=subset(dat, location==region[i] & as.numeric(as.character(bin_start_incl)) <= ilimax & target=="1 wk ahead"), 
                    aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + geom_point() + labs(title = "1 Week Ahead", x="ILI%", y="Prob")
    
    p2wk  <- ggplot(data=subset(dat, location==region[i] & as.numeric(as.character(bin_start_incl)) <= ilimax & target=="2 wk ahead"), 
                    aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + geom_point() + labs(title = "2 Week Ahead", x="ILI%", y="Prob")
    
    p3wk  <- ggplot(data=subset(dat, location==region[i] & as.numeric(as.character(bin_start_incl)) <= ilimax & target=="3 wk ahead"), 
                    aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + geom_point() + labs(title = "3 Week Ahead", x="ILI%", y="Prob")
    
    p4wk  <- ggplot(data=subset(dat, location==region[i] & as.numeric(as.character(bin_start_incl)) <= ilimax & target=="4 wk ahead"), 
                    aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + geom_point() + labs(title = "4 Week Ahead", x="ILI%", y="Prob")
    
    onstdat <- subset(dat, location==region[i] & target=="Season onset" & type=="Bin")
    onstdat$bin_start_incl <- factor(onstdat$bin_start_incl, levels=paste(c(40:52,1:20)))
    
    if(normal==TRUE){
      onstdat$value[is.na(onstdat$bin_start_incl)] <- .1
      onstdat$value[!is.na(onstdat$bin_start_incl)] <- onstdat$value[!is.na(onstdat$bin_start_incl)]/sum(onstdat$value[!is.na(onstdat$bin_start_incl)])
      onst  <- ggplot(data=onstdat, aes(x=bin_start_incl, y=value)) + 
        geom_point() + labs(title = "Season Onset", x="Week", y="Prob")
    }else{
      onst  <- ggplot(data=onstdat, aes(x=bin_start_incl, y=value)) + 
        geom_point() + labs(title = "Season Onset", x="Week", y="Prob")
    }
    
    pkper <- ggplot(data=subset(dat, location==region[i] & target=="Season peak percentage" & type=="Bin"), 
                    aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + geom_point() + labs(title = "Season Peak Percentage", x="Percent", y="Prob")
    
    pkwkdat <- subset(dat, location==region[i] & target=="Season peak week")
    pkwkdat$bin_start_incl <- factor(pkwkdat$bin_start_incl, levels=paste(c(40:52,1:20)))
    
    pkwk  <- ggplot(data=pkwkdat, aes(x=bin_start_incl, y=value)) + 
      geom_point() + ylim(0, 1) + labs(title = "Season Peak Week", x="Week", y="Prob")
    
    grid.arrange(p1wk,onst,p2wk,pkper,p3wk,pkwk,p4wk, nrow=4, ncol=2, top=paste(region[i]))
  }
  
  
  # Plots the probabilities of %ILI by region colored by week
  natplot <- ggplot(data=sbdat, aes(x=as.numeric(as.character(bin_start_incl)), y=value, color=target)) +
    geom_point(size = 1) + facet_grid(location~.) + labs(x="ILI%", y="Prob", title="ILI by Region")
  print(natplot)
  
  dev.off()
  
}