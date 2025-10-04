#!/bin/bash

# Create genome directory
mkdir -p genome
cd genome

echo "Downloading S. aureus reference genome (USA300_FPR3757)..."

# Download genome files from NCBI
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/013/465/GCF_000013465.1_ASM1346v1/GCF_000013465.1_ASM1346v1_genomic.fna.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/013/465/GCF_000013465.1_ASM1346v1/GCF_000013465.1_ASM1346v1_genomic.gff.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/013/465/GCF_000013465.1_ASM1346v1/GCF_000013465.1_ASM1346v1_genomic.gtf.gz

# Decompress files
gunzip *.gz

# Rename files for consistency
mv GCF_000013465.1_ASM1346v1_genomic.fna saureus_genome.fna
mv GCF_000013465.1_ASM1346v1_genomic.gff saureus_genome.gff
mv GCF_000013465.1_ASM1346v1_genomic.gtf saureus_genome.gtf


# Create STAR genome index directory
mkdir -p genomeIndex

echo "Building STAR genome index..."

STAR --runMode genomeGenerate \
     --genomeDir genomeIndex \
     --genomeFastaFiles genome/saureus_genome.fna \
     --runThreadN 8

echo "Genome indexing completed."
