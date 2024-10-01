#!/bin/bash
#SBATCH -J soapdenovo_assembly          # Job name
#SBATCH -p general                      # Partition (queue)
#SBATCH -o soapdenovo_output_%j.txt     # Standard output log file (%j will be replaced with job ID)
#SBATCH -e soapdenovo_error_%j.err      # Standard error log file (%j will be replaced with job ID)
#SBATCH --mail-type=ALL                 # Send email on job start, end, and fail
#SBATCH --mail-user=pthuthi@iu.edu      # Email to send notifications
#SBATCH --nodes=1                       # Number of nodes
#SBATCH --ntasks-per-node=1             # Number of tasks per node (1 core)
#SBATCH --time=24:00:00                 # Maximum runtime (24 hours, adjust as needed)
#SBATCH --mem=100GB                     # Memory allocation per node
#SBATCH -A r00750                       # Account for job submission

#Note: Tha above details are according to the IU HPC job submission, It varies for different HPC Systems. Can Always try different comabinations of Nodes, Time allocation, Memory.

# Load necessary modules 
module load miniconda

# Activate the conda environment with SOAPdenovo installed
conda activate soapdenovo_env

# Change to the working directory
cd /N/u/pthuthi/Quartz/Prasanth_NGS/Data/SRR1770413  # Update to your actual working directory

# Paired-end FASTQ files
fastq_1="/N/u/pthuthi/Quartz/Prasanth_NGS/Data/SRR1770413/SRR1770413.sra_1.fastq"
fastq_2="/N/u/pthuthi/Quartz/Prasanth_NGS/Data/SRR1770413/SRR1770413.sra_2.fastq"

# Create the configuration file for SOAPdenovo
config_file="soapdenovo.config"
cat > $config_file << EOL
max_rd_len=150
[LIB]
avg_ins=200
reverse_seq=0
asm_flags=3
rank=1
q1=${fastq_1}
q2=${fastq_2}
EOL

# Array of k-mer sizes to try (from small to large)
kmer_sizes=(23 31 41 51 63 71 81 91 101 111 127) # You can try different

# Loop through each k-mer size and run SOAPdenovo
for kmer in "${kmer_sizes[@]}"; do
    echo "Running SOAPdenovo with k-mer size $kmer"

    # Output directory for each k-mer size
    output_dir="soapdenovo_output_k${kmer}"
    mkdir -p ${output_dir}

    # Run SOAPdenovo
    SOAPdenovo-63mer all -s $config_file -K $kmer -o ${output_dir}/soapdenovo_output -p 8 -R

    echo "SOAPdenovo assembly complete for k-mer size $kmer"
done

echo "All SOAPdenovo assemblies completed!"

