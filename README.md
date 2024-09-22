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
```bash
```
### Run 

### Results
