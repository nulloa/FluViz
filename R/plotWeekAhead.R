plotWeekAhead <- function(dat, region, wk=1){
  require(ggplot2)
  require(cdcfluview)
  
  d <- subset(dat, location==region & as.numeric(as.character(bin_start_incl)) <= ilimax)
  
  NatFluDat <- get_flu_data("national", NA, "ilinet")
  RegFluDat <- get_flu_data("hhs", 1:10, "ilinet")
  NatFluDat$REGION[NatFluDat$REGION=="X"] <- "National"
  CFluDat <- rbind(tail(RegFluDat, n=10), tail(NatFluDat, n=1))[,c("REGION","% WEIGHTED ILI")]
  CurrentILIPer <- CFluDat[CFluDat$REGION==region, "% WEIGHTED ILI"]
  
  if(wk==1){
    ggplot(data=subset(d, target=="1 wk ahead"), aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + 
      geom_point() + 
      labs(title = "1 Week Ahead", x="ILI%", y="Prob") + geom_vline(xintercept = CurrentILIPer)
  }
  
  
  if(wk==2){
    ggplot(data=subset(d, target=="2 wk ahead"), aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + 
      geom_point() + 
      labs(title = "2 Week Ahead", x="ILI%", y="Prob") + geom_vline(xintercept = CurrentILIPer)
  }
  
  if(wk==3){
    ggplot(data=subset(d, target=="3 wk ahead"), aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + 
      geom_point() + 
      labs(title = "3 Week Ahead", x="ILI%", y="Prob") + geom_vline(xintercept = CurrentILIPer)
  }
  
  if(wk==4){
    ggplot(data=subset(d, target=="4 wk ahead"), aes(x=as.numeric(as.character(bin_start_incl)), y=value)) + 
      geom_point() + 
      labs(title = "4 Week Ahead", x="ILI%", y="Prob") + geom_vline(xintercept = CurrentILIPer)
  }
  
}