#' A Normalizing Onset Function
#'
#' This function allows you to normalize the onset of a CDC fluview submission.
#' @param data Expects a data csv in the form of a CDC fluview submission see FluSight package for a minimal submission
#' @param nalim Sets the max probability assigned to no onset. Defaults to 0.001.
#' @keywords Normalize Onset
#' @export
#' @examples
#' normalize_onset()

normalize_onset <- function(data, nalim=0.001){
  region <- levels(data$location)
  for(i in 1:length(region)){
    subreg <- subset(data, location==region[i] & target=="Season onset" & type=="Bin")
    subreg$bin_start_incl <- factor(as.factor(subreg$bin_start_incl))
    subreg$bin_start_incl <- factor(subreg$bin_start_incl, levels=c(paste(c(40:52,1:20),".0",sep=""),"none"))
    subreg$bin_start_incl <- c(paste(c(40:52,1:20)),NA)
    if(sum(subreg$value[!is.na(subreg$bin_start_incl)]) == 1){
      data[which(data$location==region[i] & data$target=="Season onset" & data$type=="Bin"),"value"] <- subreg$value
    }else if(subreg$value[is.na(subreg$bin_start_incl)] < nalim){
      data[which(data$location==region[i] & data$target=="Season onset" & data$type=="Bin"),"value"] <- subreg$value
    }else{
      diff <- subreg$value[is.na(subreg$bin_start_incl)] - nalim
      subreg$value[is.na(subreg$bin_start_incl)] <- nalim
      subreg$value[!is.na(subreg$bin_start_incl)] <- subreg$value[!is.na(subreg$bin_start_incl)] + (diff)/length(subreg$value[!is.na(subreg$bin_start_incl)])
      data[which(data$location==region[i] & data$target=="Season onset" & data$type=="Bin"),"value"] <- subreg$value 
    }
  }
  
  return(data)
}