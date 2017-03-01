#' A Grid Plot Function
#'
#' This function allows you to plot a grid of plots showing the Week Ahead prediction, Onset, Peak Percentage, Peak Week, and Actual current data. 
#' @param dat Expects a data csv in the form of a CDC fluview submission see \code{FluSight} package for a minimal submission
#' @param ilimax Numeric. Max level of ILI percentage to be plotted
#' @keywords grid plots
#' @export
#' @examples
#' plotgrid()

plotgrid <- function(dat, ilimx){
  require(ggplot2)
  require(gridExtra)
  require(cdcfluview)
  require(FluSight)
  
  source("R/plotcdcdata.R")
  source("R/plotOnset.R")
  source("R/plotPeakWeek.R")
  source("R/plotPeakPer.R")
  source("R/plotWeekAhead.R")
  
  # ILI Baselines for Regions 1:10, National
  ILIbaseline <- read.csv("ILIBaselines.csv")

  region <- levels(dat$location)

  week <- get_week(Sys.Date())
  week <- formatC(week, width = 2, format="d", flag="0")  
  
  pdf(paste("PredPlots/week", week, ".pdf", sep=""), width=18, height=12)

  for(i in 1:length(region)){
    
    # Plot ILI% predictions for Weeks out
    p1wk <- plotWeekAhead(dat, region=region[i], wk=1, ilimax=ilimx)
    p2wk <- plotWeekAhead(dat, region=region[i], wk=2, ilimax=ilimx)
    p3wk <- plotWeekAhead(dat, region=region[i], wk=3, ilimax=ilimx)
    p4wk <- plotWeekAhead(dat, region=region[i], wk=4, ilimax=ilimx)
    
    # Plot Onset Week Predictions
    onst  <- plotOnset(dat, region[i])
    
    # Plot Peak Percentage Predictions
    pkper <- plotPeakPer(dat, region[i])
      
    # Plot Peak Week Predictions
    pkwk  <- plotPeakWeek(dat, region[i])

    # Plot Actual % ILI up to current week
    truedat <- plotcdcdata(region[i])
    
    # Arranges various plots onto a grid
    grid.arrange(p1wk,onst,p2wk,pkper,p3wk,pkwk,p4wk,truedat, nrow=4, ncol=2, top=paste(region[i]))
  }
  
  
  # Plots the probabilities of %ILI by region colored by week
  sbdat <- subset(dat, as.numeric(as.character(bin_start_incl)) <= ilimx & 
                    target %in% c("1 wk ahead","2 wk ahead","3 wk ahead","4 wk ahead"))
  
  natplot <- ggplot(data=sbdat, aes(x=as.numeric(as.character(bin_start_incl)), y=value, color=target)) +
    geom_point(size = 1) + facet_grid(location~.) + labs(x="ILI%", y="Prob", title="ILI by Region")
    
  print(natplot)
  
  dev.off()
}







#' Get the surveillance week
#'
#' @param date A Date object or one that can be coerced to a Date object
#' @return The numeric week number
#' @importFrom MMWRweek MMWRweek
#' @seealso \code{\link{write_entry}}, \code{\link{as.Date}}
#' @keywords internal
get_week <- function(date) {
  warning("Getting a week automatically is an experimental feature. ",
          "Please check the week in the filename.")
  
  if (!is(date, "Date")) date = as.Date(date)
  
  MMWRweek::MMWRweek(date-9)$MMWRweek
}
