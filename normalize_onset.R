normalize_onset <- function(data, nalim=0.1){
  region <- levels(data$location)
  for(i in 1:length(region)){
    subreg <- subset(data, location==region[i] & target=="Season onset" & type=="Bin")
    subreg$bin_start_incl <- factor(subreg$bin_start_incl, levels=paste(c(40:52,1:20)))
    subreg$value[is.na(subreg$bin_start_incl)] <- nalim
    subreg$value[!is.na(subreg$bin_start_incl)] <- subreg$value[!is.na(subreg$bin_start_incl)]/sum(subreg$value[!is.na(subreg$bin_start_incl)])
    data[which(data$location==region[i] & data$target=="Season onset" & data$type=="Bin"),"value"] <- subreg$value
  }
  
  return(data)
}