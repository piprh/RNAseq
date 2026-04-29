#!/bin/bash

# Pseudoalign raw reads to reference transcriptome.
# Mouse transcriptome index for salmon is downloaded from refgenie 
# http://refgenomes.databio.org/v3/assets/splash/fa159612d40b1bedea9a279eb24999b3d27145f9dd70dcca/salmon_index
# Requires refgenie, salmon
# refgenie needs initiation if this is first use
# Usage: bash align.sh

if [[ -z $REFGENIE ]]; then
    read -r -p "Initialising refgenie, enter genome storage location:   " IndexDir
    refgenie init -c $IndexDir/genome_config.yaml
    export REFGENIE=$IndexDir/genome_config.yaml
fi

refgenie pull --no-overwrite mm10_cdna/salmon_index