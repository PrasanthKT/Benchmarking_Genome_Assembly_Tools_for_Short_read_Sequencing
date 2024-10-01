#!/bin/bash
#SBATCH -J abyss_assembly              # Job name
#SBATCH -p general                      # Partition (queue)
#SBATCH -o abyss_output_%j.txt          # Standard output log file (%j will be replaced with job ID)
#SBATCH -e abyss_error_%j.err           # Standard error log file
#SBATCH --mail-type=ALL                 # Send email on job start, end, and fail
#SBATCH --mail-user=pthuthi@iu.edu      # Email to send notifications
#SBATCH --nodes=1                       # Number of nodes
#SBATCH --ntasks-per-node=1             # Number of tasks per node (1 core)
#SBATCH --time=24:00:00                 # Maximum runtime (24 hours, adjust as needed)
#SBATCH --mem=100GB                     # Memory allocation per node
#SBATCH -A r00750                       # Account for job submission

#Note: Tha above details are according to the IU HPC job submission, It varies for different HPC Systems. Can Always try different comabinations of Nodes, Time allocation, Memory.

# Load the necessary module (replace with the actual module on your system)
module load miniconda

# Activate the conda environment
conda activate assembly_project

# Change to your working directory
cd /N/u/pthuthi/Quartz/Prasanth_NGS/Data/SRR1770413 # Update to your actual working directory

# Ensure output directory exists
mkdir -p abyss_output

# Paired-end FASTQ files
fastq_1=SRR1770413.sra_1.fastq
fastq_2=SRR1770413.sra_2.fastq

# Array of k-mer sizes to try
kmer_sizes=(21 31 41 51 61 71 81 91 101 111 127) # You can try different k-mers

# Loop through each k-mer size and run ABySS
for kmer in "${kmer_sizes[@]}"; do
    echo "Running ABySS with k-mer size $kmer"

    # Create a directory for each k-mer size
    output_dir="abyss_output_k${kmer}"
    mkdir -p ${output_dir}

    # Run ABySS
    abyss-pe k=${kmer} name=${output_dir}/abyss_output in="${fastq_1} ${fastq_2}"

    echo "ABySS assembly complete for k-mer size $kmer"
done

echo "All ABySS assemblies completed!"

