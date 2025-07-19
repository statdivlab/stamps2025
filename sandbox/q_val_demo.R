library(tidyverse)
library(radEmu)
library(qvalue)

pvals <- readRDS("sandbox/our_ps_compare.RDS")

summary(pvals)
ggplot(pvals, aes(x = pval_score)) + 
  geom_histogram(fill = "gray", color = "black") + 
  theme_bw() + 
  labs(x = "P-value", y = "Count") + 
  theme(axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16))
qvals <- qvalue::qvalue(pvals$pval_score)
ggsave("sandbox/pval_dist.png")
ggplot(data.frame(q = qvals$qvalues), aes(x = q)) + 
  geom_histogram(fill = "gray", color = "black") + 
  theme_bw() + 
  labs(x = "Q-value", y = "Count") + 
  theme(axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16))
ggsave("sandbox/qval_dist.png")
sum(pvals$pval_score <= 0.05)
sum(qvals$qvalues <= 0.05)
data.frame(p = pvals$pval_score, q = qvals$qvalues) %>%
  arrange(q) %>%
  head(20)
