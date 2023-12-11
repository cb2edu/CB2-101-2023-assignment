#!/bin/bash

# Download 
wget -O NC_000913.faa https://ftp.ncbi.nlm.nih.gov/genomes/archive/old_refseq/Bacteria/Escherichia_coli_K_12_substr__MG1655_uid57779/NC_000913.faa

# Count the number of protein sequences
num_sequences=$(grep -c '^>' NC_000913.faa)

# Calculate the total length of proteins
total_length=$(grep -v '^>' NC_000913.faa | tr -d '\n' | wc -c)

# Calculate the average protein length
average_length=$(echo "scale=2; $total_length / $num_sequences" | bc)

# Print the average protein length
echo "Average protein length: $average_length"
