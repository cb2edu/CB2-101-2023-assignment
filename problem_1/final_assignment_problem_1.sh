## Problem 1

# Write a bash script that takes a fasta file as an input and print out the average protein length in the file.
# Note: You can use E. coli MG1655 proteome file to test your script. The file can be downloaded from here: https://ftp.ncbi.nlm.nih.gov/genomes/archive/old_refseq/Bacteria/Escherichia_coli_K_12_substr__MG1655_uid57779/NC_000913.faa.
# Note:
# 1. You must use only bash commands. No other programming language is allowed.
# 2. You may need the following commands in bash to complete this task. wget, zcat, wc, tr, bc, and grep. You are not restricted to any of these commands. You can use any or all or any other bash
# commands in your script or command line.

#!/bin/bash

wget https://ftp.ncbi.nlm.nih.gov/genomes/archive/old_refseq/Bacteria/Escherichia_coli_K_12_substr__MG1655_uid57779/NC_000913.faa

file="NC_000913.faa"
cat $file | head

sequences=$(awk '/^>/ {next} {gsub(/ /,""); print}' "$file")

readarray -t sequences_array <<< "$sequences"

total_length=0
num_sequences=0
for sequence in "${sequences_array[@]}"; do
    sequence_length=${#sequence}
    total_length=$((total_length + sequence_length))
    ((num_sequences++))
done

if [ "$num_sequences" -gt 0 ]; then
    average_length=$((total_length / num_sequences))
    echo "Average protein length in $file is: $average_length"
else
    echo "No sequences found in the input file."
fi








