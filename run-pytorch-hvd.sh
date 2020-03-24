#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=10
#SBATCH --partition=gpu
#SBATCH --gres=gpu:v100:2,nvme:100
#SBATCH --time=1:00:00
#SBATCH --mem=64G
#SBATCH --account=project_2002675
#SBATCH --reservation=arcada_dl

module purge
module load pytorch/1.3.1-hvd-mpich
# Use this module if pytorch/1.3.1-hvd-mpich does not work correctly.
# module load pytorch/1.3.1-hvd
module list

export DATADIR=/scratch/project_2002675/extracted
export TMPDIR=$LOCAL_SCRATCH

set -xv
python3.7 $*
