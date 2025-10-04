echo "Running FastQC on raw reads..."
fastqc raw_data/*.fastq.gz -o fastqc/ -t 8

# Generate MultiQC report
multiqc fastqc/ -o fastqc/ -n raw_reads_multiqc
