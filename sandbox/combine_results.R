# radEmu results
folder <- "stamps_radEmu/res/"

# List matching files in that folder
files <- list.files(path = folder, pattern = "^res\\d+\\.rds$", full.names = TRUE)

if (length(files) > 0) {
  # Read and bind all single-row data frames
  combined_df <- do.call(rbind, lapply(files, readRDS))
  head(combined_df)
  saveRDS(combined_df, "stamps_radEmu/rad_res.rds")
}

# fastEmu results
folder <- "stamps_radEmu/fast_res/"

# List matching files in that folder
files <- list.files(path = folder, pattern = "^res\\d+\\.rds$", full.names = TRUE)

if (length(files) > 0) {
  # Read and bind all single-row data frames
  fast_combined_df <- do.call(rbind, lapply(files, readRDS))
  head(fast_combined_df)
  saveRDS(fast_combined_df, "stamps_radEmu/fast_res.rds")
}
