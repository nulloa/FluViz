normalize_onset <- function(data, nalim=0.1){
  region <- levels(data$location)
  for(i in 1:length(region)){
    subreg <- subset(data, location==region[i] & target=="Season onset" & type=="Bin")
    subreg$bin_start_incl <- factor(subreg$bin_start_incl, levels=paste(c(40:52,1:20)))
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