require("FluSight")
source("R/normalize_onset.R")

dat <- read.csv("https://raw.githubusercontent.com/NLMichaud/hierarchicalSIRMods/master/currentSeasonPredictions/submittedCSVs/EW51-ISU-2017-01-03.csv?token=AFk8HZotqLeuNjvWs0-PDrgsEf1hK2yGks5YdPyVwA%3D%3D", header=TRUE)
normdat <- normalize_onset(dat, nalim=.001)

write.csv(normdat, file="temp.csv", row.names=FALSE, col.names=FALSE)
entryDataFrame <- read_entry("temp.csv")
write_entry(entryDataFrame,path="NormalizedSubmittedCSV",team="ISU") 
file.remove("temp.csv")
