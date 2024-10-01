#!/bin/bash
#SBATCH -J quast_abyss_comparison        # Job name
#SBATCH -p general                       # Partition (queue)
#SBATCH -o quast_abyss_output_%j.txt     # Standard output log (%j will be replaced with job ID)
#SBATCH -e quast_abyss_error_%j.err      # Standard error log (%j will be replaced with job ID)
#SBATCH --mail-type=ALL                  # Send email on job start, end, and fail
#SBATCH --mail-user=pthuthi@iu.edu       # Email to send notifications
#SBATCH --nodes=1                        # Number of nodes
#SBATCH --ntasks-per-node=1              # Number of tasks per node (1 core)
#SBATCH --time=06:00:00                  # Maximum runtime (6 hours)
#SBATCH --mem=50GB                       # Memory allocation (50GB)
#SBATCH -A r00750                        # Account for job submission

#Note Quast analysis takes very less but I have givenn good memeory and time to aggregate the results

# Load the necessary QUAST module
module load miniconda

#Activate Conda Environment
conda activate assembly_project

# Change to the directory 
cd /N/u/pthuthi/Quartz/Prasanth_NGS/Data/SRR1770413/Output_Files/ABYss 

# Run QUAST to compare all ABYSS assemblies
quast -o quast_abyss_output -t 8 -l "k21,k31,k41,k51,k61,k71,k81,k91,k101,k111,k127" \      
    abyss_output_k21/abyss_output-1.fa \
    abyss_output_k31/abyss_output-1.fa \
    abyss_output_k41/abyss_output-1.fa \
    abyss_output_k51/abyss_output-1.fa \
    abyss_output_k61/abyss_output-1.fa \
    abyss_output_k71/abyss_output-1.fa \
    abyss_output_k81/abyss_output-1.fa \
    abyss_output_k91/abyss_output-1.fa \
    abyss_output_k101/abyss_output-1.fa \
    abyss_output_k111/abyss_output-1.fa \
    abyss_output_k127/abyss_output-1.fa

echo "QUAST analysis completed for ABYSS assemblies!"

