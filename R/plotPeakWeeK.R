plotPeakWeek <- function(dat, region){
  require(ggplot2)
  
  d <- subset(dat, location==region & target=="Season peak week" & type=="Bin")
  
  d$bin_start_incl <- factor(factor(as.factor(d$bin_start_incl)), levels=c(40:52,1:20))
  
  ggplot(data=pkwkdat, aes(x=bin_start_incl, y=value)) + 
    geom_point() + ylim(0, 1) + labs(title = "Season Peak Week", x="Week", y="Prob")
}