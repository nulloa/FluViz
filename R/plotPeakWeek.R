#' A Peak Week Plot Function
#'
#' This function allows you to plot Peak Week Predictions
#' @param dat Expects a data csv in the form of a CDC fluview submission see \code{FluSight} package for a minimal submission
#' @param region Specifies the region to be plotted
#' @keywords Peak Week Prediction Plot
#' @export
#' @examples
#' plotPeakWeek()


plotPeakWeek <- function(dat, region){
  require(ggplot2)
  
  d <- subset(dat, location==region & target=="Season peak week" & type=="Bin")
  
  d$bin_start_incl <- factor(factor(as.factor(d$bin_start_incl)), levels=c(40:52,1:20))
  
  ggplot(data=d, aes(x=bin_start_incl, y=value)) + 
    geom_point() + ylim(0, 1) + labs(title = "Season Peak Week", x="Week", y="Prob")
}