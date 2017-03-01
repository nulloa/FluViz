# # Load in packages
# require(ggplot2)
# require(gridExtra)
# require(cdcfluview)
# 
# # Grab data for particular yrs
# yrs <- c(2000:2014)
# NatFluDat <- get_flu_data("national", NA, "ilinet", years=yrs)
# RegFluDat <- get_flu_data("hhs", 1:10, "ilinet", years=yrs)
# 
# # Combine the data
# dat <- rbind(NatFluDat,RegFluDat)
# dat$REGION[dat$REGION=="X"] <- "National"
# 
# # Relevel the region
# dat$REGION <- factor(dat$REGION,
#                      levels=c("Region 1","Region 2","Region 3",
#                               "Region 4","Region 5","Region 6",
#                               "Region 7","Region 8","Region 9",
#                               "Region 10","National"))
# 
# # Remove Rows with no data
# dat$'% WEIGHTED ILI' <- as.numeric(as.character(dat$'% WEIGHTED ILI'))
# dat <- dat[which(!is.na(dat$'% WEIGHTED ILI')),]
# 
# # Turn some variables into factors
# dat$YEAR <- factor(dat$YEAR)
# dat$SEASON <- rep(NA, nrow(dat))
# 
# # Creates Seasons variable
# for(i in 1:(nlevels(dat$YEAR)-1)){
#   dat[dat$YEAR==levels(dat$YEAR)[i] & dat$WEEK >= 40 & dat$WEEK <= 52,"SEASON"] <- paste(levels(dat$YEAR)[i], "-", levels(dat$YEAR)[i+1], sep="")
#   dat[dat$YEAR==levels(dat$YEAR)[i+1] & dat$WEEK >= 1 & dat$WEEK <= 20,"SEASON"] <- paste(levels(dat$YEAR)[i], "-", levels(dat$YEAR)[i+1], sep="")
# }
# dat$SEASON <- factor(dat$SEASON)
# 
# # Turn Week into factor so it will print nicely
# dat$WEEK <- factor(dat$WEEK, levels=paste(c(40:52,1:20)))
# region <- levels(dat$REGION)
# 
# 
# # Plot to pdf
# pdf("HistFluPlot.pdf", width=18, height=12)
# for(i in 1:length(region)){
#   subd <- subset(dat, REGION==region[i])
#   plot <- ggplot(data=subd, aes(x=WEEK, y=subd$'% WEIGHTED ILI', color=SEASON)) + 
#     geom_line()+geom_point()+ylab("Actual % ILI")+
#     geom_line(aes(group = SEASON))+labs(title = paste(region[i]))
#   print(plot)
# }
# dev.off()
# 
# targetdat <- create_truth(fluview = FALSE, weekILI = valid_ILI, year=yrs[1])
# targetdat$Year <- rep(yrs[1], nrow(targetdat))
# for(i in 2:length(yrs)){
#   add <- create_truth(fluview = FALSE, weekILI = valid_ILI, year=yrs[i])
#   add$Year <- rep(yrs[i], nrow(add))
#   targetdat <- rbind(targetdat,add)
# }
# targetdat$target <- factor(targetdat$target)
# targetdat$Year <- factor(targetdat$Year)
# 
# onset <- ggplot(data=subset(targetdat, target=="Season onset"), aes(x=location,y=bin_start_incl,color=Year))+geom_point()
# pkper <- ggplot(data=subset(targetdat, target=="Season peak percentage"), aes(x=location,y=bin_start_incl))
# pkwk  <- ggplot(data=subset(targetdat, target=="Season peak week"), aes(x=location,y=bin_start_incl))




