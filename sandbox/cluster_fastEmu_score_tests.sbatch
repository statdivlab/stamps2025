#!/bin/bash
#SBATCH --job-name fast_stamps_wirbel
#SBATCH --partition short
#SBATCH --ntasks 1
#SBATCH --time 0-11:59
#SBATCH --mem-per-cpu=8000
#SBATCH --array=1-758
#SBATCH --output fast_stamps_%j.out
#SBATCH --error fast_stamps_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=teichs@uw.edu

module load R-bundle-CRAN 
Rscript stamps_radEmu/cluster_fastEmu_score_tests.R $SLURM_ARRAY_TASK_ID