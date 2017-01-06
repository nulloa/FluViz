plotPeakPer <- function(dat, region){
  require(ggplot2)
  
  d <- subset(dat, location==region & target=="Season peak percentage" & type=="Bin")
  
  ggplot(data=d, aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + 
    geom_point() + labs(title = "Season Peak Percentage", x="Percent", y="Prob")
}