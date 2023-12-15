#Problem 2
r <- readLines("https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/variants/humsavar.txt",skipNul = T)
begin <- grep("^____", r, perl = T)
end <- grep("^---", r, perl = T)
end <- end[4]
r_data <- r[(begin+1):(end-2)]
d <- read.table(textConnection(r_data), fill = T, stringsAsFactors = F, sep="", flush = T)
d<- d[, -ncol(d)]
write.table(d, "humsavar.tsv", row.names = F, col.names = F, quote = F, sep="\t")

#(1)
filtered_data <- subset(d, V5 != "LB/B")
Gene_counts <- table(filtered_data$V1)
sorted_Gene_counts <- sort(Gene_counts, decreasing = TRUE)
top_5_categories <- head(sorted_Gene_counts, 5)
top_5_categories

#(2)

install.packages("ggplot2")
library(ggplot2)

ggplot(filtered_data, aes(y = V1)) +
  geom_bar(fill = "skyblue", color = "black") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1)) +
  labs(title = "Frequency Distribution of Disease Variants Across Genes", x = "Frequency", y = "Genes")

#(3)

average_mutations <- mean(Gene_counts)
ggplot(filtered_data, aes(y = V1)) +
  geom_bar(fill = "skyblue", color = "black") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1)) +
  labs(title = "Frequency Distribution of Disease Variants Across Genes", x = "Frequency", y = "Genes") +
  geom_vline(xintercept = average_mutations, color = "red", linetype = "dashed")

#(4)
mutations <- filtered_data$V4
affected_aa <- gsub(".*p\\.([A-Z][a-z]{2})(\\d+)[A-Z][a-z]{2}.*", "\\1", mutations)
aa_counts <- table(affected_aa)
aa_freq <- aa_counts / sum(aa_counts)
aa_freq <- aa_freq[order(names(aa_freq))]
amino_acids <- names(aa_freq)
barplot(aa_freq, col = "gray", 
        main = "Fraction of Mutations Affecting Each Amino Acid", 
        xlab = "Amino Acid", ylab = "Fraction",
        names.arg = amino_acids,
        las = 2, cex.names = 0.8)

