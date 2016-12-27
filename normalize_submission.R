library("FluSight")
source("normalize_onset.R")

dat <- read.csv("https://raw.githubusercontent.com/NLMichaud/hierarchicalSIRMods/master/currentSeasonPredictions/submittedCSVs/EW50-ISU-2016-12-26.csv?token=AFk8He0xOdnyVqdhjkqe8uqAm5y33Temks5YavlrwA%3D%3D", header=TRUE)
normdat <- normalize_onset(dat, nalim=.001)

write.csv(normdat, file="temp.csv", row.names=FALSE, col.names=FALSE)
entryDataFrame <- read_entry("temp.csv")
write_entry(entryDataFrame,path="NormalizedSubmittedCSV",team="ISU") 
file.remove("temp.csv")
