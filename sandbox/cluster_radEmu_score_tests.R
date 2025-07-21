library(radEmu)
library(tidyverse)

# get ind
args <- commandArgs(trailingOnly = FALSE)
if (length(args) == 0) {
  batch <- 1
} else {
  arg <- args[length(args)]
  batch <- abs(readr::parse_number(arg))
}

data("wirbel_sample")
data("wirbel_otu")
mOTU_names <- colnames(wirbel_otu)
wirbel_sample$Group <- factor(wirbel_sample$Group, levels = c("CTR","CRC"))
ch_study_obs <- which(wirbel_sample$Country %in% c("CHI"))

abundances_subset <- wirbel_otu[ch_study_obs, ]
sum(rowSums(abundances_subset) == 0) # zero samples have a count sum of 0
sum(colSums(abundances_subset) == 0) # 87 mOTUs have count sums of 0

categories_to_rm <- which(colSums(abundances_subset) == 0)
abundances_subset <- abundances_subset[, -categories_to_rm]
sum(colSums(abundances_subset) == 0) ## good

ch_fit <- readRDS("stamps_radEmu/ch_fit.rds")

# run test
res <- data.frame(batch = batch,
                  tax = ch_fit$coef$category[batch],
                  pval = NA,
                  time = NA)
start <- proc.time()
test <- emuFit(formula = ~ Group,
               data = wirbel_sample[ch_study_obs, ],
               Y = abundances_subset,
               compute_cis = FALSE,
               test_kj = data.frame(k = 2, j = batch),
               fitted_model = ch_fit,
               refit = FALSE)
end <- proc.time() - start 
res$pval <- test$coef$pval[batch]
res$time <- end[3]

saveRDS(res, paste0("stamps_radEmu/res/res", batch, ".rds"))
