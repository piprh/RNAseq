#!/bin/bash

# Quality control of fastq files using FastQC and MultiQC.
# Requires FastQC and MultiQC installed.
# Usage: bash qc.sh

# Initialize input directory
WorkDir="$(pwd)/data"
cd $WorkDir

# Initialize output directory for QC reports
mkdir -p "fqc_reports"
mkdir -p "mqc_reports"

# Run FastQC on all fastq files in the data directory
fastqc -o $WorkDir/fqc_reports/ $WorkDir/*.fastq.gz

FQCFiles="$(ls -p fqc_reports | grep -v / | wc -l)"
printf "FastQC complete, %s files created." "${FQCFiles}"

echo "Starting MultiQC"

# Run MultiQC on all fastqc reports
multiqc $WorkDir/fqc_reports -o $WorkDir/mqc_reports

MQCFiles="$(ls -p mqc_reports | grep -v / | wc -l)"
printf "MultiQC complete, %s files created." "${MQCFiles}"



