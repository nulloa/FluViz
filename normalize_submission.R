library("FluSight")
source("normalize_onset.R")

dat <- read.csv("https://raw.githubusercontent.com/NLMichaud/hierarchicalSIRMods/master/currentSeasonPredictions/submittedCSVs/EW48-ISU-2016-12-12.csv?token=AFk8HQV20wboes4cSdTxk_uYPyDAlClEks5YWJ60wA%3D%3D", header=TRUE)
normdat <- normalize_onset(dat)

write.csv(normdat, file="temp.csv", row.names=FALSE, col.names=FALSE)
entryDataFrame <- read_entry("temp.csv")
write_entry(entryDataFrame,path="NormalizedSubmittedCSV",team="ISU") 
file.remove("temp.csv")
