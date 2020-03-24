#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=10
#SBATCH --job-name=hvd-pt-4nodes-16gpus
#SBATCH --output=horovod-pytorch-resnet50-imagenet.stdout.%j
#SBATCH --error=horovod-pytorch-resnet50-imagenet.stderr.%j
#SBATCH --partition=gpu
#SBATCH --gres=gpu:v100:4,nvme:60
#SBATCH --time=1:00:00
#SBATCH --mem=80G
#SBATCH --account=project_2002675
#xSBATCH --reservation=arcada_dl

# Hint: Use same values for --gres=gpu:v100:n and --ntasks-per-node=n

# How to obtain the pytorch_imagenet_resnet50.py training script:
# git clone https://github.com/horovod/horovod
# cd horovod
# git checkout 3237ccc6d4bbc0b439cd9d18d8bffb4c9b2c8e4f

# Clear the currently loaded software modules
module purge

# Load the required software modules (Includes python3.7, PyTorch, Horovod, MPI libraries etc.)
module load pytorch/1.3.1-hvd-mpich

# Specify path to the dataset tar archive
DATASET_TAR_ARCHIVE=/scratch/project_2002675/datasets/ilsvrc2012-torch-resized-new.tar

# Extract dataset tar archive to compute nodes local nvme storage
srun --ntasks=$SLURM_NNODES --ntasks-per-node=1 tar xf $DATASET_TAR_ARCHIVE --strip 1 -C $LOCAL_SCRATCH/

# We use per worker batch size 256 to speed up things. You might want to concider using a smaller per worker batch size when scaling out to multiple nodes.
# A good learning rate for RestNet50 + ImageNet is learning rate 0.1 for batch size 256 (See: https://arxiv.org/abs/1706.02677)
# Launch the training script
srun python3.7 horovod/examples/pytorch_imagenet_resnet50.py \
               --batch-size=256 \
               --base-lr=0.1 \
	       --epochs=1 \
               --train-dir=${LOCAL_SCRATCH}/train \
               --val-dir=${LOCAL_SCRATCH}/val
