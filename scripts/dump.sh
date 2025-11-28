#!/bin/bash

# Download fastq files directly from online repository using fasterq-dump.
# Requires internet connection and SRA toolkit installed.
# Usage: bash dump.sh

#Initialize output directory
if [ ! -d "data" ]; then
    mkdir data
fi

# Download each accession
acc=($(seq 46 51))
for i in "${acc[@]}"; do
    echo "SRR311699$i"
    fasterq-dump --split-files "SRR311699$i" -O data
    rm -fr "SRR311699$i"
done

echo "Download complete. "
