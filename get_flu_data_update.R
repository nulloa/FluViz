get_flu_data <- function (region = "hhs", sub_region = 1:10, data_source = "ilinet", years = as.numeric(format(Sys.Date(), "%Y"))) {
  region <- tolower(region)
  data_source <- tolower(data_source)
  if (!(region %in% c("hhs", "census", "national"))) 
    stop("Error: region must be one of hhs, census or national")
  if (length(region) != 1) 
    stop("Error: can only select one region")
  if (region == "national") 
    sub_region = ""
  if ((region == "hhs") && !all(sub_region %in% 1:10)) 
    stop("Error: sub_region values must fall between 1:10 when region is 'hhs'")
  if ((region == "census") && !all(sub_region %in% 1:19)) 
    stop("Error: sub_region values must fall between 1:10 when region is 'census'")
  if (!all(data_source %in% c("who", "ilinet"))) 
    stop("Error: data_source must be either 'who', 'ilinet' or both")
  if (any(years < 1997)) 
    stop("Error: years should be > 1997")
  years <- years - 1960
  reg <- as.numeric(c(hhs = 1, census = 2, national = 3)[[region]])
  data_source <- gsub("who", "WHO_NREVSS", data_source)
  data_source <- gsub("ilinet", "ILINet", data_source)
  params <- list(SubRegionsList = paste0(sub_region, collapse = ","), 
                 DataSources = paste0(data_source, collapse = ","), RegionID = reg, 
                 SeasonsList = paste0(years, collapse = ","))
  out_file <- tempfile(fileext = ".zip")
  tmp <- POST("https://gis.cdc.gov/grasp/fluview/FluViewPhase2CustomDownload.ashx", 
              body = params, write_disk(out_file))
  stop_for_status(tmp)
  if (!(file.exists(out_file))) 
    stop("Error: cannot process downloaded data")
  out_dir <- tempdir()
  files <- unzip(out_file, exdir = out_dir, overwrite = TRUE)
  file_list <- pblapply(files, function(x) {
    ct <- ifelse(grepl("who", x, ignore.case = TRUE), 0, 
                 1)
    read.csv(x, header = TRUE, skip = ct, stringsAsFactors = FALSE)
  })
  names(file_list) <- substr(basename(files), 1, 3)
  if (length(file_list) == 1) {
    return(file_list[[1]])
  }
  else {
    return(file_list)
  }
}
