#!/usr/bin/bash

input_file=$1

# number of amino acids = (remove header lines | delete line spacings | count chars)
n_aa=$(cat $input_file | grep -v '^>' | tr -d '\n' | wc -c)

# number of sequences = (count occurances of lines starting with ">")
n_seq=$(cat $input_file | grep -c '^>')

echo "The average protein length is:"
echo "`echo "$n_aa / $n_seq" | bc` amino acids"