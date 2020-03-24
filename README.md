## Exercises

The exercises in this repository are based on [CSC's Introduction to deep learning](https://github.com/csc-training/intro-to-dl/tree/master/day2) exercises.

### Setup

1. Login to Puhti using a training account:

        ssh -l trainingxxx puhti.csc.fi
        
2. Clone and cd to the exercise repository:

        git clone https://github.com/nyholmju/arcada_dl.git exercises
        cd exercises

### Edit and submit jobs

1. Edit and submit jobs:

        nano tf2-test.py  # or substitute with your favorite text editor
        sbatch run-tf2.sh tf2-test.py # submit job 

   There is a separate slurm script for PyTorch, e.g.:
   
        sbatch run-pytorch.sh pytorch_dvc_cnn_simple.py

   You can also specify additional command line arguments, e.g.

        sbatch run-tf2.sh tf2-dvc-cnn-evaluate.py dvc-cnn-simple.h5

2. See the status of your jobs or the queue you are using:

        squeue -l -u trainingxxx
        squeue -l -R arcada_dl # If using slurm reservation
        squeue -l -p gpu

3. After the job has finished, examine the results:

        less slurm-xxxxxxxx.out

4. Repeat steps 1 to 3  until you are happy with the results.

5. Optional: Check batch jobs run time and resource utilization using `seff`

        seff slurmjobid # The slurm job id is the xxxxxxxx part in the file name (slurm-xxxxxxxx.out)


### Exercise 1

Image classification: dogs vs. cats; traffic signs.

#### TF2/Keras

* *tf2-dvc-cnn-simple.py*: Dogs vs. cats with a CNN trained from scratch
* *tf2-dvc-cnn-pretrained.py*: Dogs vs. cats with a pre-trained CNN
* *tf2-dvc-cnn-evaluate.py*: Evaluate a trained CNN with test data
* *tf2-gtsrb-cnn-simple.py*: Traffic signs with a CNN trained from scratch
* *tf2-gtsrb-cnn-pretrained.py*: Traffic signs with a pre-trained CNN
* *tf2-gtsrb-cnn-evaluate.py*: Evaluate a trained CNN with test data

To evaluate on the test set append model file name as a command line argument, e.g. `sbatch run-tf2.sh tf2-dvc-cnn-evaluate.py dvc-cnn-simple.h5` 

#### PyTorch

The PyTorch scripts have a slightly different setup:

* *pytorch_dvc_cnn_simple.py*: Dogs vs cats with a CNN trained from scratch
* *pytorch_dvc_cnn_pretrained.py*: Dogs vs cats with a pre-trained CNN
* *pytorch_dvc_cnn.py*: Common functions for Dogs vs cats (don't run this one directly)
* *pytorch_gtsrb_cnn_simple.py*: Traffic signs with a CNN trained from scratch
* *pytorch_gtsrb_cnn_pretrained.py*: Traffic signs with a pre-trained CNN
* *pytorch_gtsrb_cnn.py*:  Common functions for Traffic signs (don't run this one directly)

To evaluate on the test set run with the `--test` option, e.g. `sbatch run-pytorch.sh pytorch_dvc_cnn_simple.py --test` 

#### Optional 1:

Dogs vs. cats with data in TFRecord format: 

* *tf2-dvc_tfr-cnn-simple.py*: Dogs vs. cats with a CNN trained from scratch
* *tf2-dvc_tfr-cnn-pretrained.py*: Dogs vs. cats with a pre-trained CNN
* *tf2-dvc_tfr-cnn-evaluate.py*: Evaluate a trained CNN with test data

#### Optional 2:

There is another, small dataset `avp`, of aliens and predators. Modify dogs vs. cats to classify between them.  

#### Optional 3:

Use local storage in Puhti to speed up disk access.
   - See [run-tf2-lscratch.sh](run-tf2-lscratch.sh), which copies the dogs-vs-cats dataset to `$LOCAL_SCRATCH`, and try for example with [tf2-dvc-cnn-simple.py](tf2-dvc-cnn-simple.py).
   - Also, see https://docs.csc.fi/#computing/running/creating-job-scripts/#local-storage for more information.

### Exercise 2
Experiment with Horovod to implement multi-GPU training.
   - See [run-pytorch-hvd.sh](run-pytorch-hvd.sh) and [pytorch_dvc_cnn_simple_hvd.py](pytorch_dvc_cnn_simple_hvd.py). 
   - See [run-tf2-hvd.sh](run-tf2-hvd.sh) and [tf2-dvc-cnn-simple-hvd.py](tf2-dvc-cnn-simple-hvd.py). 
   - Do you get improvements in speed when running on 2 GPUs?
   - Do you get the same accuracy than with a single GPU?

