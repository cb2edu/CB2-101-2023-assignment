#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <fasta_file>"
    exit 1
fi

fasta_file="$1"

avg_length=$(awk '/^>/ {if (seqlen) {print seqlen}; seqlen=0; next} {seqlen += length($0)} END {print seqlen}' "$fasta_file" | awk '{ total += $1; count++ } END { print total/count }')

echo "Average protein length: $avg_length"

#Then: I made the file excutable by: chmod +x First_Problem.sh

#Then I Calculate Avg length by: ./First_Problem.sh NC_000913.faa

#Result: 316.859