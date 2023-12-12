#Problem 3_part1
install.packages("data.table")
library(data.table)

# Change this path according to your file location
file_path <- "/home/cb2user/R/assignment/: Homo_sapiens.gene_info"

# Read the tab-delimited gene_info file
gene_info <- read.delim(file_path)

# Subset the gene_info data frame to include only 'Symbol' and 'chromosome' columns
gene_info_subset <- gene_info[, c("Symbol", "chromosome")]
head(gene_info_subset)

# Remove rows with | in the chromosome column
gene_info_clean <- gene_info_subset[!grepl("\\|", gene_info_subset$chromosome), ]

# Convert chromosome column to factor with ordered levels
gene_info_clean$chromosome <- factor(gene_info_clean$chromosome,
                                     levels = c(as.character(1:22), "X", "Y"))
# Count the number of genes in each chromosome
chromosome_counts <- table(gene_info_clean$chromosome)
c# Convert counts to a data frame

chromosome_data <- data.frame(Chromosome = names(chromosome_counts),
                              Gene_Count = as.numeric(chromosome_counts))

# Create the ordered bar plot
ggplot(chromosome_data, aes(x = Chromosome, y = Gene_Count)) +
  geom_bar(stat = "identity", fill = "grey") +
  labs(x = "Chromosomes", y = "Gene Count", title = "Number of genes in each chromosome") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

#Problem 3_part2 (b)
new_values <- c(
  248956422, 242193529, 198295559, 190214555, 181538259, 170805979, 159345973, 145138636,138394717, 133797422,
  135086622, 133275309, 114364328, 107043718, 101991189, 90338345, 83257441, 80373285, 58617616, 64444167, 46709983, 50818468, 156040895,
  57227415)

# Add the 'Length_C' column to the chromosome_data
chromosome_data$Length_C <- new_values
chromosome_data

# Fit a linear regression model
model <- lm(Gene_Count ~ Length_C,  data = chromosome_data)
summary(model)

# correlation coefficient
correlation <- cor(chromosome_data$Gene_Count, chromosome_data$Length_C)
correlation

# plot the regression data with the trendline
ggplot(chromosome_data, aes(x = as.numeric(gsub(",", "", Length_C)), y = Gene_Count)) +
  geom_point() +  # Scatter plot of the data points
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, color = "blue") +  # Fitted regression line
  labs(x = "Length of Chromosome", y = "Gene Count", title = "Fitted Regression Line") +
  theme_minimal()
# Calculate the Rˆ2 and other statistics to determine
#R-squared:  0.7158,
# p-value: 1.912e-07
#Model is significant
#Number of Genes Expected for each Chromosome

# Get the fitted values
fitted_values <- predict(model, newdata = chromosome_data)
fitted_values

#95% Confidence interval for Regression
ggplot(chromosome_data, aes(x=Length_C, y=Gene_Count)) + 
  geom_point(color='#2980B9', size = 4) + 
  geom_smooth(method=lm, color='#2C3E50')+labs(x = "Length of Chromosome", y = "Gene Count", title = "Fitted Regression Line")


#Problem 3_part1 (C)
# Function to get chromosome name with highest or lowest count
get_chromosome <- function(data, type = "highest") {
  if (type == "highest") {
    return(data$Chromosome[which.max(data$Gene_Count)])
  } else if (type == "lowest") {
    return(data$Chromosome[which.min(data$Gene_Count)])
  } else {
    stop("Invalid type argument. Please use 'highest' or 'lowest'.")
  }
}

highest_count_chromosome <- get_chromosome(chromosome_data, "highest")
lowest_count_chromosome <- get_chromosome(chromosome_data, "lowest")

cat("Chromosome with the highest count:", highest_count_chromosome, "\n")
cat("Chromosome with the lowest count:", lowest_count_chromosome, "\n")






