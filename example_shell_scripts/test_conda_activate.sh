#!/bin/bash -l
#SBATCH -J conda_test   #jobname
#SBATCH -N 1     #node
#SBATCH --tasks-per-node=1
#SBATCH -p bigmem
#SBATCH --mail-type=END
#SBATCH --mail-user=$USER@st-andrews.ac.uk

cd /gpfs1/home/$USER/
pyv="$(python -V 2>&1)"
echo "$pyv"
# conda to activate the software
echo $PATH
conda activate spades
pyv="$(python -V 2>&1)"
echo "$pyv"
echo $PATH


conda deactivate 
echo $PATH
conda activate python27

pyv="$(python2 -V 2>&1)"
echo "$pyv"

echo $PATH
