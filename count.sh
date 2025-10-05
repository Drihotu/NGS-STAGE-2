#!/usr/bin/env bash
# Script: 05_counting.sh
# FeatureCounts script for S. aureus (single-end reads)
# Requires: subread (featureCounts)

# Set variables
ANNOTATION="saureus_genome.gff"
BAM_DIR="mapped"
OUT_DIR="counts"
THREADS=4

# Create output directory
mkdir -p "$OUT_DIR"

echo ">>> Running featureCounts..."

featureCounts \
    -T $THREADS \
    -O \
    -t gene \
    -g ID \
    -s 0 \  # Change to 1 or 2 if your data is stranded
    -a "$ANNOTATION" \
    -o "$OUT_DIR/counts.txt" \
    "$BAM_DIR"/*_Aligned.sortedByCoord.out.bam

# Display summary
echo ">>> Count summary:"
cat "$OUT_DIR/counts.txt.summary"

echo ">>> Gene counting complete!"
echo "    - Counts in: $OUT_DIR/counts.txt"
echo "    - BAM files used from: $BAM_DIR
