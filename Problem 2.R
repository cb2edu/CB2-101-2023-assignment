#Problem 2
# Read the Swissvar file
humsavar <- read.csv("humsavar.csv", header = TRUE)

# Set column names
colnames(humsavar) <- c("Gene", "Swiss_prot_AC", "FTId", "AA_change", "Variant_category", "dbSNP", 'Disease_name')

# Filter out non-disease causing variants
disease_variants <- humsavar[humsavar$Variant_category %in% c("LB/B"), ]

# Merge disease variants with gene information
merged_data <- merge(disease_variants, gene_info_subset, by.x = "Gene", by.y = "Symbol")

# Count the number of disease variants per chromosome
chromosome_variant_counts <- table(merged_data$chromosome)
chromosome_variant_counts = data.frame(chromosome_variant_counts)
colnames(chromosome_variant_counts) = c('chromosome', 'variant_counts')

# Order the data by chromosome
chromosome_variant_counts$chromosome <- factor(chromosome_variant_counts$chromosome, levels = chromosome_order)

# Sort the frequencies in descending order
sorted_Gene_counts <- sort(chromosome_variant_counts, decreasing = TRUE)

# Select the top 5 categories based on frequency
top_5_categories <- head(sorted_Gene_counts, 5)

#(1)
# Display the top 5 categories and their frequencies
top_5_categories

#(2)
# Plot the data
ggplot(chromosome_variant_counts, aes(x = chromosome, y = variant_counts)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Concentration of Disease Variants in Human Chromosomes",
       x = "Chromosome",
       y = "Number of Disease Variants") +
  theme_minimal()

pdf("Concentration of Disease Variants in Human Chromosomes.pdf",  width = 8, height = 8)
print(p)
dev.off()