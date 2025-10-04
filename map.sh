#!/bin/bash
# Script: 04_mapping_star.sh
# Script for mapping S. aureus with STAR (paired-end reads)
# and indexing BAM files for IGV

# Directories
GENOME_DIR="genomeIndex"
TRIM_DIR="trimmed"
OUT_DIR="mapped"

mkdir -p "$OUT_DIR"

# 1. Run STAR alignment for each pair of trimmed FASTQ files
for r1 in "$TRIM_DIR"/*_1_trimmed.fastq.gz; do
    [ -e "$r1" ] || continue

    # Get sample name by removing the _1_trimmed.fastq.gz suffix
    sample=$(basename "$r1" _1_trimmed.fastq.gz)
    r2="$TRIM_DIR/${sample}_2_trimmed.fastq.gz"

    echo ">>> Aligning sample: $sample"

    STAR --genomeDir "$GENOME_DIR" \
         --readFilesIn "$r1" "$r2" \
         --readFilesCommand zcat \
         --runThreadN 8 \
         --outFileNamePrefix "$OUT_DIR/${sample}_" \
         --outSAMtype BAM SortedByCoordinate \
         --outSAMattributes All
done

# 2. Index all BAMs for IGV
echo ">>> Indexing BAM files..."
for bam in "$OUT_DIR"/*Aligned.sortedByCoord.out.bam; do
    samtools index "$bam"
done

echo ">>> All alignments complete and indexed!"
