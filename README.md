# Benchmarking_Genome_Assembly_Tools

### Introduction
Genome assembly is the process of reconstructing the original DNA sequence of an organism's genome from fragmented sequencing reads. It involves piecing together millions of short DNA sequences to recreate longer contiguous sequences that represent chromosomes or large genomic regions.
1. De novo assembly: Reconstructing the genome sequence without using a reference genome.
2. Reference-guided assembly: Using a closely related species' genome as a template to guide the assembly process.
Genome assembly tools, also known as assemblers, are software programs designed to perform this complex task. They employ various algorithms and strategies to overcome challenges like repetitive sequences, sequencing errors, and uneven coverage.

### Objective
This project aims to benchmark various genome assembly tools using an E. coli dataset. The goals is  to:
Evaluate assembly performance based on:
1. Execution time
2. Memory usage
3. Computational resource utilization
4. Assembly quality (contiguity, completeness, accuracy)
5. Provide a comprehensive comparison to guide tool selection for E. coli and similar bacterial genome projects
6. Identify trade-offs between assembly quality and computational efficiency

### Tools selcted for benchmarking
1. SPAdes
2. Velvet
3. AByss
4. SOAPdenovo2
5. ALLPATHS-LG

### Install the above tools
```bash
conda install -c bioconda spades
conda install -c bioconda velvet
conda install -c bioconda abyss
conda install -c bioconda soapdenovo2
conda install biobuilds::allpathslg
```
### Dependencies
1. Conda
2. Bioconda
3. 
### Run 

### Results
