#!/bin/bash
#SBATCH --job-name combine
#SBATCH --partition short
#SBATCH --ntasks 1
#SBATCH --time 0-11:59
#SBATCH --mem-per-cpu=8000
#SBATCH --output combine_%j.out
#SBATCH --error combine_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=teichs@uw.edu

module load R-bundle-CRAN 
Rscript stamps_radEmu/combine_results.R