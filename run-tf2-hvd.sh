#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=10
#SBATCH --partition=gpu
#SBATCH --gres=gpu:v100:2
#SBATCH --time=1:00:00
#SBATCH --mem=64G
#SBATCH --account=project_2002675
#SBATCH --reservation=arcada_dl

module purge
module load tensorflow/2.0.0-hvd
module list

export DATADIR=/scratch/project_2002675/extracted/

set -xv
srun python3.7 $*

