# Third Problem

# 3.1

library(data.table)
file_path <- "/media/sf_Cb2_Class/2023_assignment/CB2-101-2023-assignment/Homo_sapiens.gene_info"

gene_info <- read.delim(file_path)

gene_info_subset <- gene_info[, c("Symbol", "chromosome")]
head(gene_info_subset)
gene_info_clean <- gene_info_subset[!grepl("\\|", gene_info_subset$chromosome), ]
gene_info_clean$chromosome <- factor(gene_info_clean$chromosome,
                                     levels = c(as.character(1:22), "X", "Y"))

chromosome_counts <- table(gene_info_clean$chromosome)

chromosome_data <- data.frame(Chromosome = names(chromosome_counts),
                              Gene_Count = as.numeric(chromosome_counts))

ggplot(chromosome_data, aes(x = Chromosome, y = Gene_Count)) +
  geom_bar(stat = "identity", fill = "black") +
  labs(x = "Chromosomes", y = "Gene Count", title = "Number of genes in each chromosome") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

# 3.2
new_values <- c(
  248956422, 242193529, 198295559, 190214555, 181538259, 170805979, 159345973, 145138636,138394717, 133797422,
  135086622, 133275309, 114364328, 107043718, 101991189, 90338345, 83257441, 80373285, 58617616, 64444167, 46709983, 50818468, 156040895,
  57227415)

chromosome_data$Length_C <- new_values
chromosome_data

model <- lm(Gene_Count ~ Length_C,  data = chromosome_data)
summary(model)


correlation <- cor(chromosome_data$Gene_Count, chromosome_data$Length_C)
correlation


ggplot(chromosome_data, aes(x = as.numeric(gsub(",", "", Length_C)), y = Gene_Count)) +
  geom_point() +  
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, color = "red") +  
  labs(x = "Length of Chromosome", y = "Gene Count", title = "Fitted Regression Line") +
  theme_minimal()

fitted_values <- predict(model, newdata = chromosome_data)
fitted_values

ggplot(chromosome_data, aes(x=Length_C, y=Gene_Count)) + 
  geom_point(color='#2980B9', size = 4) + 
  geom_smooth(method=lm, color='#2C3E50')+labs(x = "Length of Chromosome", y = "Gene Count", title = "Fitted Regression Line")

# 3.3

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

