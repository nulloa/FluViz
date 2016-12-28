require("FluSight")
source("normalize_onset.R")

dat <- read.csv("https://raw.githubusercontent.com/NLMichaud/hierarchicalSIRMods/master/currentSeasonPredictions/submittedCSVs/EW50-ISU-2016-12-27.csv?token=AFk8HTS07BUJLihbjx_XZHXudv_qK7ruks5YbDthwA%3D%3D", header=TRUE)
normdat <- normalize_onset(dat, nalim=.001)

write.csv(normdat, file="temp.csv", row.names=FALSE, col.names=FALSE)
entryDataFrame <- read_entry("temp.csv")
write_entry(entryDataFrame,path="NormalizedSubmittedCSV",team="ISU") 
file.remove("temp.csv")
