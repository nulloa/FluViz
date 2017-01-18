plotcdcdata <- function(region){
  require(ggplot2)
  require(cdcfluview)
  
  if(region=="US National"){
    d <- get_flu_data("national", NA, "ilinet") 
  }else{
    d <- get_flu_data("hhs", as.numeric(unlist(strsplit(region, " "))[3]), "ilinet")
  }

  ILIbaseline <- read.csv("ILIBaselines.csv")
  
  d$WEEK <- factor(factor(as.factor(d$WEEK)), levels=c(c(40:52,1:20),"none"))
  
  ggplot(data=d, aes(x=WEEK, y=d$'% WEIGHTED ILI')) + 
    geom_line(aes(group=1)) + geom_point() + ylab("Actual % ILI") +
    geom_hline(yintercept = ILIbaseline$Baselines[ILIbaseline$Region==region])
  
  
}