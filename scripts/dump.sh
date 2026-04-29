#!/bin/bash

# Download fastq files directly from online repository using fasterq-dump.
# Requires internet connection and SRA toolkit installed. 
# Usage: bash dump.sh

#Initialize output directory
mkdir -p data

# Prefetch all accessions
prefetch --option-file acclist.txt ## Make sure acclist.txt contains the correct accession numbers.

# Download each accession as fastq files and remove intermediate files
acc=($(seq 795 800)) ## Edit to include the correct accession numbers.
for i in "${acc[@]}"; do
    echo "fasterq-dump GSM8603${i}"
    fasterq-dump --split-files "GSM8603${i}" -O "data/"
    rm -fr "GSM8603${i}"
done

# Compress the downloaded fastq files to save space
gzip -r data/
