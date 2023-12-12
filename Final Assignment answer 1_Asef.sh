#!/bin/bash

# Download the E. coli MG1655 proteome file
wgetNC_000913.faa.gz https://ftp.ncbi.nlm.nih.gov/genomes/archive/old_refseq/Bacteria/Escherichia_coli_K_12_substr__MG1655_uid57779/NC_000913.faa.gz

# Unzip the downloaded file
zcat NC_000913.faa.gz > proteome.faa

# Extract protein lengths and calculate the average
average_length= $(grep -o '^>\S+' proteome.faa | tr -d '>' | wc -m)
num_proteins= $(grep -c '^>' proteome.faa)
average_length= $((average_length / num_proteins))

print(average_length)