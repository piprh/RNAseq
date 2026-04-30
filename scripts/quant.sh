#!/bin/bash

# Quantify samples.
# Requires salmon, refgenie
# Usage: bash quant.sh

# Pull mouse transcriptome index for salmon from refgenie.
# http://refgenomes.databio.org/v3/assets/splash/fa159612d40b1bedea9a279eb24999b3d27145f9dd70dcca/salmon_index
# refgenie needs initiation if this is first use
if [[ -z $REFGENIE ]]; then
    read -r -p "Initialising refgenie, enter genome storage location:   " IndexDir
    refgenie init -c $IndexDir/genome_config.yaml
    export REFGENIE=$IndexDir/genome_config.yaml
fi

# --no-overwrite flag looks for correct existing local index
refgenie pull --no-overwrite mm10_cdna/salmon_index
refgenie pull --no-overwrite mm10/gencode_gtf #This is needed for downstream analysis


GenomeDir="data/genome/GCF_000001635.27"
#Get files from data/ > keep only fastq files > keep only sample prefix up to "_" delimeter > remove duplicate samples
FilesIn="$(find data | grep fastq.gz | awk -F'_' '{print $1}' | sort -u)"
Index="$(refgenie seek mm10_cdna/salmon_index)"

#Quantifying samples
for fn in $FilesIn;
do
samp=`basename ${fn}`
echo "Processing sample ${samp}"
#Consider using --gcBias flag recommended by bioconductor tximport vignette
#   MultiQC shows negotiable GC bias so maybe no diff
salmon quant -i $Index -l A \
         -1 ${fn}_1.fastq.gz \
         -2 ${fn}_2.fastq.gz \
         -p 8 --validateMappings -o quants/${samp}_quant
done 

