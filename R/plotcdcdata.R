plotcdcdata <- function(region){
  require(ggplot2)
  require(cdcfluview)
  
  if(region=="US National"){
    d <- get_flu_data("national", NA, "ilinet") 
  }else{
    d <- get_flu_data("hhs", as.numeric(unlist(strsplit(region, " "))[3]), "ilinet")
  }

  ILIbaseline <- read.csv("ILIBaselines.csv")
  
  ggplot(data=d, aes(x=WEEK, y=d$'% WEIGHTED ILI')) + 
    geom_line() + geom_point() + ylab("Actual % ILI") + scale_x_continuous(breaks=d$WEEK) +
    geom_hline(yintercept = ILIbaseline$Baselines[ILIbaseline$Region==region])
  
  
}