# Benchmarking_Genome_Assembly_Tools

### Introduction
Genome assembly is the process of reconstructing the original DNA sequence of an organism's genome from fragmented sequencing reads. It involves piecing together millions of short DNA sequences to recreate longer contiguous sequences that represent chromosomes or large genomic regions.

1. De novo assembly: Reconstructing the genome sequence without using a reference genome.
2. Reference-guided assembly: Using a closely related species' genome as a template to guide the assembly process.

Genome assembly tools, also known as assemblers, are software programs designed to perform this complex task. They employ various algorithms and strategies to overcome challenges like repetitive sequences, sequencing errors, and uneven coverage.

### Objective
This project aims to benchmark various genome assembly tools using an E. coli dataset. The objectves are to

1. Evaluate performance of each tool based on:

Execution time
Memory usage
Computational resource utilization
Assembly quality (contiguity, completeness, accuracy)

2. Provide a comprehensive comparison to guide tool selection for E. coli and similar bacterial genome projects
3. Identify trade-offs between assembly quality and computational efficiency

### Tools selcted for benchmarking
1. SPAdes
2. Velvet
3. AByss
4. SOAPdenovo2

Out of all the above SPAdes, Velvet and ABYss are De bruijin graph based genome assembly tools and SOAPDenovo2 is based on Overlap layout consensus genome assembly tool but all the tools are short read sequencing assemblers, since the selected genome type is also a short read sequecing of genome assembly tools. So performed becnhmarking of all these tools on E.Coli Data to evaluate the above metioned parameters.

### Installation
```bash
conda install -c bioconda spades
conda install -c bioconda velvet
conda install -c bioconda abyss
conda install -c bioconda soapdenovo2
```
### Dependencies
1. Conda
2. Bioconda
3. SRA Toolkit
4. FASTQC
5. QUAST (Quality Assessment tools for genome assembly)
```bash
conda install -c bioconda sra-tools
conda install -c bioconda quast
```
### Workflow Summary
1. Data Download: Sequences were downloaded from NCBI-SRA using ```prefetch``` and converted to FASTQ using ```fastq-dump```
```
prefetch SRR1770413
fastq-dump --split-files SRR1770413.sra
```
2. Quality Control: FASTQC was used to assess the quality of the paired-end reads.
 ```
fastqc SRR1770413_1.fastq -o Fastqc_results/
fastqc SRR1770413_2.fastq -o Fastqc_results/
```
3. Genome Assembly: Genome assembly was performed using multiple tools (Velvet, SPAdes, SOAPdenovo, ALLPATHS-LG, ABYSS) across a range of k-mer sizes (21-127).

Velvet:
```
velveth velvet_output 31 -shortPaired -fastq -separate SRR1770413_1.fastq SRR1770413_2.fastq
velvetg velvet_output -exp_cov auto -cov_cutoff auto
```

SOAPdenovo
```
SOAPdenovo-63mer all -s soapdenovo.config -K 63 -R -o soapdenovo_output/soapdenovo 
```

ABYss
```
abyss-pe k=41 name=abyss_output in='SRR1770413_1.fastq SRR1770413_2.fastq'
```

SPAdes
```
spades.py --careful -k 21,31,41,51,61,71,81,91,101 -1 SRR1770413_1.fastq -2 SRR1770413_2.fastq -o spades_output
```
4. Quality Assessment: The assemblies were analyzed using QUAST for standard metrics such as N50, GC content, and total contig length.

### Results
Detailed assembly results are present in the repository as ```Results.xlsx``` and in the Quast_Results directory

The main metrics that were taken into consideration include:
1. N50 and N90: These metrics measure the contiguity of the assembly.
2. GC Content: Percentage of GC content in the assembly.
3. Total Length and Longest Contig: Indicates the overall assembly size and the size of the largest contig.
4. Number of Contigs: The total number of contigs generated in the assembly.
5. Computational and Memory Efficiency: These metrics were obtained from the job outputs on the HPC system.
