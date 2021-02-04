#!/bin/bash
#SBATCH -J sm
#SBATCH -o out
#SBATCH -e err
#SBATCH -p holy-info
#SBATCH -n 1
#SBATCH -t 9000
#SBATCH --mem=10000

module purge
module load Anaconda/5.0.1-fasrc02

conda activate mk
snakemake --snakefile Snakefile_vcf2mk --profile ./profiles/slurm
