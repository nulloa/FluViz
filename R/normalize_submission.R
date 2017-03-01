#' A Submission Normalizing Function
#'
#' This function will return a CDC fluview submission with the onset probabilities normalized
#' @param data Expects a data csv in the form of a CDC fluview submission see FluSight package for a minimal submission
#' @param nalim Sets the max probability assigned to no onset. Defaults to 0.001.
#' @param team Sets team name for csv submission file name. Defaults to ISU.
#' @keywords normalize
#' @export
#' @examples
#' normSubmission()

normSubmission <- function(data, nalim=0.001, team="ISU"){
  require("FluSight")
  source("R/normalize_onset.R")
  
  normdat <- normalize_onset(dat, nalim=nalim)
  
  write.csv(normdat, file="temp.csv", row.names=FALSE, col.names=FALSE)
  entryDataFrame <- read_entry("temp.csv")
  write_entry(entryDataFrame,path="NormalizedSubmittedCSV",team=team) 
  file.remove("temp.csv")
}