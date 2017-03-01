#' A Onset Plot Function
#'
#' This function allows you to plot Onset Predictions
#' @param dat Expects a data csv in the form of a CDC fluview submission see \code{FluSight} package for a minimal submission
#' @param region Specifies the region to be plotted
#' @keywords Onset Prediction Plot
#' @export
#' @examples
#' plotOnset()

plotOnset <- function(dat, region){
  require(ggplot2)
  
  d <- subset(dat, location==region & target=="Season onset" & type=="Bin")
  
  d$bin_start_incl <- factor(factor(as.factor(d$bin_start_incl)), levels=c(c(40:52,1:20),"none"))
  
  ggplot(data=d, aes(x=bin_start_incl, y=value)) + 
    geom_point() + labs(title = "Season Onset", x="Week", y="Prob")
}