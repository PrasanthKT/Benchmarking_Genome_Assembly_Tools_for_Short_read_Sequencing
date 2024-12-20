# Benchmarking_Genome_Assembly_Tools

### Introduction
Genome assembly is the process of reconstructing the original DNA sequence of an organism's genome from fragmented sequencing reads. It involves piecing together millions of short DNA sequences to recreate longer contiguous sequences that represent chromosomes or large genomic regions.
There are two types of assemblies:
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
1. Velvet
2. AByss
3. SOAPdenovo2

### Installation of the assemblers
```bash
conda install -c bioconda velvet
conda install -c bioconda abyss
conda install -c bioconda soapdenovo2
```
Out of all the above Velvet and ABYss are De bruijin graph based genome assembly tools and SOAPDenovo2 is based on Overlap layout consensus genome assembly tool but all the tools are short read sequencing assemblers, since the selected genome type is also a short read sequecing of genome assembly tools. So performed becnhmarking of all these tools on E.Coli Data to evaluate the above metioned parameters.

### Dependencies
1. Conda
2. Bioconda
3. SRA Toolkit
4. FASTQC
```bash
conda install -c bioconda sra-tools
```
5. QUAST (Quality Assessment tools for genome assembly)
```bash
conda install -c bioconda quast
```
### Workflow Summary
1. Data Download: Sequences were downloaded from NCBI-SRA using ```prefetch``` and converted to FASTQ using ```fastq-dump```
```
prefetch SRR1770413
fastq-dump --split-files SRR1770413.sra
```
2. Quality Control: FASTQC was used to assess the quality of the paired-end reads. The fastqc results are located in the ```FASTQC``` directory.
 ```
fastqc SRR1770413_1.fastq -o Fastqc_results/
fastqc SRR1770413_2.fastq -o Fastqc_results/
```
3. Genome Assembly: Genome assembly was performed using multiple tools (Velvet, SPAdes, SOAPdenovo,ABYSS) across a range of k-mer sizes (21-127).
The following commands are used for genome assembly with individual k-mers. However, multiple k-mer assemblies can be executed simultaneously on the HPC. The job scripts located in the ```Job_Scripts``` directory allow you to run assemblies for all desired k-mers at once.

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

4. Quality Assessment: The assemblies were analyzed using QUAST for standard metrics such as N50, GC content, and total contig length.

### Results
Detailed assembly results are present in the repository as ```Results.xlsx``` and in the ```Quast_Results``` directory

The main metrics that were taken into consideration include:
1. N50 and N90: These metrics measure the contiguity of the assembly.
2. GC Content: Percentage of GC content in the assembly.
3. Total Length and Longest Contig: Indicates the overall assembly size and the size of the largest contig.
4. Number of Contigs: The total number of contigs generated in the assembly.
5. Computational and Memory Efficiency: These metrics were obtained from the job outputs on the HPC system.

### Conclusion
1. Workflow Consistency: All tools followed the same workflow, starting with the smallest k-mer and increasing to k=127, with identical memory and node allocation on the HPC         system.
2. Assembly Differences: Differences in results are due to the unique algorithms each tool employs. The results are most applicable to small bacterial genomes like E. coli.
3. N50 Value: Velvet produced the highest N50 value, indicating better contiguity. It uses the de Bruijn graph approach, making it highly effective for small genomes.
4. Longest Contig: Velvet assembled the longest contig and had the highest total assembly length at k=127, outperforming the other tools.
   Computational Efficiency: Velvet took the longest time for assembly, reflecting the trade-off between computational time and assembly quality.

Tool Summary:
1. Velvet shows a higher N50 and N90 compared to SOAPdenovo and Abyss across different k-mer sizes. This indicates that Velvet assemblies are more contiguous. SOAPdenovo and Abyss generally have lower N50 and N90 values, showing less contiguous assemblies.
2. The GC content is fairly consistent across all assemblers, aligning with the expected GC content for E. coli. There are no significant differences in GC content between the tools.
3. Velvet again performs better, having the longest contig and total length in most cases, especially at larger k-mer sizes. SOAPdenovo and Abyss produce shorter total lengths and longest contigs. Velvet produces fewer contigs, indicating that it is able to assemble the genome into larger, more continuous sequences. SOAPdenovo and Abyss generate more contigs, which reflects a more fragmented assembly.

Velvet consistently outperforms SOAPdenovo and Abyss in terms of assembly contiguity (N50, N90) and produces longer contigs with fewer fragments. The computational trade-off is that Velvet may take more time and resources, but it provides better overall assembly quality for E. coli. SOAPdenovo and Abyss could be useful when computational resources are more limited or when a quick, rough assembly is needed. However, for high-quality assemblies, Velvet is the preferred choice.
