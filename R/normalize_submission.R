require("FluSight")
source("R/normalize_onset.R")

url <- "https://raw.githubusercontent.com/NLMichaud/hierarchicalSIRMods/master/currentSeasonPredictions/submittedCSVs/EW01-ISU-2017-01-16.csv?token=AFk8HboySA71l67WHVIeSBIAR7awxoLqks5Yh6RKwA%3D%3D"
dat <- read.csv(url, header=TRUE)
normdat <- normalize_onset(dat, nalim=.001)

write.csv(normdat, file="temp.csv", row.names=FALSE, col.names=FALSE)
entryDataFrame <- read_entry("temp.csv")
write_entry(entryDataFrame,path="NormalizedSubmittedCSV",team="ISU") 
file.remove("temp.csv")
