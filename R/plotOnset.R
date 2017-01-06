plotOnset <- function(dat, region){
  require(ggplot2)
  
  d <- subset(dat, location==region & target=="Season onset" & type=="Bin")
  
  d$bin_start_incl <- factor(factor(as.factor(d$bin_start_incl)), levels=c(c(40:52,1:20),"none"))
  
  ggplot(data=d, aes(x=bin_start_incl, y=value)) + 
    geom_point() + labs(title = "Season Onset", x="Week", y="Prob")
}