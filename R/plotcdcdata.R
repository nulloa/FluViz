#' A CDC Data Plot Function
#'
#' This function allows you to plot current and past CDC data.
#' @param region Specifies the region to be plotted.
#' @param years Specifies years to retrieve data for (i.e. 2014 for CDC flu season 2014-2015). Default value is the current year and all years values should be > 1997
#' @keywords CDC FluView
#' @export
#' @examples
#' plotcdcdata()


plotcdcdata <- function(region,years=NA){
  require(ggplot2)
  require(cdcfluview)
  
  if(region=="US National"){
    if(is.na(years)){
      d <- get_flu_data("national", NA, "ilinet") 
    }else{
      d <- get_flu_data("national", NA, "ilinet", years=years) 
    }
  }else{
    if(is.na(years)){
      d <- get_flu_data("hhs", as.numeric(unlist(strsplit(region, " "))[3]), "ilinet")
    }else{
      d <- get_flu_data("hhs", as.numeric(unlist(strsplit(region, " "))[3]), "ilinet", years=years)
    }
  }

  ILIbaseline <- read.csv("ILIBaselines.csv")
  
  d$WEEK <- factor(factor(as.factor(d$WEEK)), levels=c(c(40:52,1:20),"none"))
  
  ggplot(data=d, aes(x=WEEK, y=d$'% WEIGHTED ILI')) + 
    geom_line(aes(group=1)) + geom_point() + ylab("Actual % ILI") +
    geom_hline(yintercept = ILIbaseline$Baselines[ILIbaseline$Region==region])
}