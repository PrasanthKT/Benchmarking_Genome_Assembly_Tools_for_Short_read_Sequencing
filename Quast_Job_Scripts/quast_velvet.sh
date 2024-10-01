#!/bin/bash
#SBATCH -J quast_velvet_comparison        # Job name
#SBATCH -p general                        # Partition (queue)
#SBATCH -o quast_velvet_output_%j.txt     # Standard output log (%j will be replaced with job ID)
#SBATCH -e quast_velvet_error_%j.err      # Standard error log (%j will be replaced with job ID)
#SBATCH --mail-type=ALL                   # Send email on job start, end, and fail
#SBATCH --mail-user=pthuthi@iu.edu        # Email to send notifications
#SBATCH --nodes=1                         # Number of nodes
#SBATCH --ntasks-per-node=1               # Number of tasks per node (1 core)
#SBATCH --time=06:00:00                   # Maximum runtime (6 hours)
#SBATCH --mem=50GB                        # Memory allocation (50GB)
#SBATCH -A r00750                         # Account for job submission

# Note: QUAST analysis takes less memory, but extra memory and time have been allocated for processing multiple assemblies.

# Load the necessary QUAST module
module load miniconda

# Activate Conda Environment
conda activate assembly_project

# Change to the directory where Velvet outputs are located
cd /N/u/pthuthi/Quartz/Prasanth_NGS/Data/SRR1770413/Output_Files/velvet_output

# Run QUAST to compare all Velvet assemblies
quast -o quast_velvet_output -t 8 -l "k21,k31,k41,k51,k61,k71,k81,k91,k101,k111,k127" \
    velvet_output_k21/contigs.fa \
    velvet_output_k31/contigs.fa \
    velvet_output_k41/contigs.fa \
    velvet_output_k51/contigs.fa \
    velvet_output_k61/contigs.fa \
    velvet_output_k71/contigs.fa \
    velvet_output_k81/contigs.fa \
    velvet_output_k91/contigs.fa \
    velvet_output_k101/contigs.fa \
    velvet_output_k111/contigs.fa \
    velvet_output_k127/contigs.fa

echo "QUAST analysis completed for Velvet assemblies!"

