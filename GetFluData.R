source('https://raw.githubusercontent.com/cmu-delphi/delphi-epidata/master/code/client/delphi_epidata.R')
res <- Epidata$fluview(list('nat'), list(201540))
cat(paste(res$result, res$message, length(res$epidata), "\n"))
res <- as.data.frame(matrix(unlist(res$epidata), ncol=14, byrow=TRUE))
colnames(res) <- c("release_date","region","issue","epiweek",
                   "lag","num_ili","num_patients","num_providers",
                   "num_age_0","num_age_1","num_age_2","num_age_5",
                   "wili","ili")
res


require(cdcfluview)
require(dplyr)
get_flu_data("national", c("ilinet"), years=2015) %>% filter(WEEK==40)
