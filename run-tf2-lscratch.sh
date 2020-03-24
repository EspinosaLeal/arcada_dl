#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --partition=gpu
#SBATCH --gres=gpu:v100:1,nvme:10
#SBATCH --time=1:00:00
#SBATCH --mem=64G
#SBATCH --account=project_2002675
#SBATCH --reservation=arcada_dl

module purge
module load tensorflow/2.0.0
module list

export DATADIR=$LOCAL_SCRATCH

set -xv

tar xf /scratch/project_2002675/datasets/dogs-vs-cats.tar -C $LOCAL_SCRATCH

srun python3.7 $*
