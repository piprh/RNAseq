#!/bin/bash

# Download fastq files directly from online repository using fasterq-dump.
# Requires internet connection and SRA toolkit installed.
# Usage: bash dump.sh

#Initialize output directory
if [ ! -d "data" ]; then
    mkdir data
fi

# Prefetch all accessions
prefetch --option-file srr_acclist.txt

# Download each accession as fastq files and remove intermediate files
acc=($(seq 77 82))
for i in "${acc[@]}"; do
    echo "SRR298907${i}"
    fasterq-dump --split-files "data/SRR298907${i}" -O "data/"
    rm -fr "SRR298907${i}"
done

gzip -r data/
