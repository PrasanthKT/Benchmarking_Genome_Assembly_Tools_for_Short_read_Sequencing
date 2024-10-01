#!/bin/bash
#SBATCH -J quast_soapdenovo_comparison    # Job name
#SBATCH -p general                        # Partition (queue)
#SBATCH -o quast_soap_output_%j.txt       # Standard output log (%j will be replaced with job ID)
#SBATCH -e quast_soap_error_%j.err        # Standard error log (%j will be replaced with job ID)
#SBATCH --mail-type=ALL                   # Send email on job start, end, and fail
#SBATCH --mail-user=pthuthi@iu.edu        # Email to send notifications
#SBATCH --nodes=1                         # Number of nodes
#SBATCH --ntasks-per-node=1               # Number of tasks per node (1 core)
#SBATCH --time=06:00:00                   # Maximum runtime (6 hours)
#SBATCH --mem=50GB                        # Memory allocation (50GB)
#SBATCH -A r00750                         # Account for job submission

#Note: Quast takes very less time for analysis, but I have still allocated good memory and time

# Load the necessary QUAST module
module load miniconda

#Activate Conda Environment
conda activate assembly_project

# Change to the directory where the SOAPdenovo output is located
cd /N/u/pthuthi/Quartz/Prasanth_NGS/Data/SRR1770413/Output_Files/SOAPdenovo # Adjust the path as needed

# Run QUAST to compare all SOAPdenovo assemblies
quast -o quast_soapdenovo_output -t 8 -l "k23,k31,k41,k51,k63,k71,k81,k91,k101,k111,k127" \
    soapdenovo_output_k23/soapdenovo_output.contig \
    soapdenovo_output_k31/soapdenovo_output.contig \
    soapdenovo_output_k41/soapdenovo_output.contig \
    soapdenovo_output_k51/soapdenovo_output.contig \
    soapdenovo_output_k63/soapdenovo_output.contig \
    soapdenovo_output_k71/soapdenovo_output.contig \
    soapdenovo_output_k81/soapdenovo_output.contig \
    soapdenovo_output_k91/soapdenovo_output.contig \
    soapdenovo_output_k101/soapdenovo_output.contig \
    soapdenovo_output_k111/soapdenovo_output.contig \
    soapdenovo_output_k127/soapdenovo_output.contig

echo "QUAST analysis completed for SOAPdenovo assemblies!"

