library("FluSight")
source("normalize_onset.R")

dat <- read.csv("https://raw.githubusercontent.com/NLMichaud/hierarchicalSIRMods/master/currentSeasonPredictions/submittedCSVs/EW47-ISU-2016-12-05.csv?token=AFk8HZjYB9bB1BwTbqLfzIC3rsRYHeyGks5YTtJ2wA%3D%3D", header=TRUE)
normdat <- normalize_onset(dat)

write.csv(normdat, file="temp.csv", row.names=FALSE, col.names=FALSE)
entryDataFrame <- read_entry("temp.csv")
write_entry(entryDataFrame,path="NormalizedSubmittedCSV",team="ISU") 
file.remove("temp.csv")
