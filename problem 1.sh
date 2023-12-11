#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <fasta_file>"
    exit 1
fi

# Download the E. coli MG1655 proteome file
wget -O NC_000913.faa.gz https://ftp.ncbi.nlm.nih.gov/genomes/archive/old_refseq/Bacteria/Escherichia_coli_K_12_substr__MG1655_uid57779/NC_000913.faa

# Unzip the downloaded file
zcat NC_000913.faa.gz > proteome.faa

# Extract protein lengths and calculate the average
average_length=$(grep -oP '^>\S+\s' NC_000913.faa.gz | tr -d '>' | wc -m) 
num_proteins=$(grep -c '^>' NC_000913.faa.gz)
average_length=$((average_length / num_proteins))

# Print the result
echo "Average protein length in the file: $average_length"

# Average protein length in the file: 30

# Clean up temporary files
rm NC_000913.faa.gz proteome.faa
