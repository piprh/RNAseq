#!/bin/bash

# Quantify samples.
# Requires salmon
# Usage: bash quant.sh

GenomeDir="data/genome/GCF_000001635.27"
#Get files from data/ > keep only fastq files > keep only sample prefix > remove duplicate samples
FilesIn="$(find data | grep fastq.gz | awk -F'_' '{print $1}' | sort -u)"
Index="$(refgenie seek mm10_cdna/salmon_index)"

for fn in $FilesIn;
do
samp=`basename ${fn}`
echo "Processing sample ${samp}"
salmon quant -i $Index -l A \
         -1 ${fn}_1.fastq.gz \
         -2 ${fn}_2.fastq.gz \
         -p 8 --validateMappings -o quants/${samp}_quant
done 

