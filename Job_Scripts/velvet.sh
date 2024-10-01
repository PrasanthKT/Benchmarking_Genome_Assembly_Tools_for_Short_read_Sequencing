#!/bin/bash
#SBATCH -J velvet_assembly              # Job name
#SBATCH -p general                      # Partition
#SBATCH -o velvet_output_%j.txt         # Standard output log file (%j will be replaced with job ID)
#SBATCH -e velvet_error_%j.err          # Standard error log file
#SBATCH --mail-type=ALL                 # Send email on job start, end, and fail
#SBATCH --mail-user=pthuthi@iu.edu      # Email
#SBATCH --nodes=1                       # Number of nodes
#SBATCH --ntasks-per-node=1             # Number of tasks per node (1 core)
#SBATCH --time=6:00:00                  # Maximum runtime (6 hours)
#SBATCH --mem=100GB                     # Memory allocation per node
#SBATCH -A r00750                       # Account for job submission

#Note: Tha above details are according to the IU HPC job submission, It varies for different HPC Systems. Can Always try different comabinations of Nodes, Time allocation, Memory.

# Load the necessary module 
module load miniconda


# Activate the conda enviornment that contains the genome assembly tools
conda activate assembly_project

# Change to your working directory
cd /N/u/pthuthi/Quartz/Prasanth_NGS/Data/SRR1770413/Input_Files # Update to your actual working directory

# Ensure output directory exists
mkdir -p velvet_output_3


# Array of k-mer sizes to try. This is my choice of K-mers for the E.Coli Genome Assembly.
kmer_sizes=(21 31 41 51 61 71 81 91 101 111 127)  # Add or remove k-mer sizes as needed

# Paired-end FASTQ files
fastq_1=SRR1770413.sra_1.fastq
fastq_2=SRR1770413.sra_2.fastq

# Loop through each k-mer size and run Velvet
for kmer in "${kmer_sizes[@]}"; do
    echo "Running Velvet with k-mer size $kmer"

    # Create a directory for each k-mer size
    output_dir="velvet_output_k${kmer}"
    mkdir -p ${output_dir}

    # Run velveth to generate the hash table
    velveth ${output_dir} ${kmer} -shortPaired -fastq -separate ${fastq_1} ${fastq_2}

    # Run velvetg to assemble the genome
    velvetg ${output_dir} -exp_cov auto -cov_cutoff auto

    echo "Velvet assembly complete for k-mer size $kmer"
done

echo "All Velvet assemblies completed!"


