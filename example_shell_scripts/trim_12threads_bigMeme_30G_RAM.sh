#!/bin/bash -l
#SBATCH -J trimmo   #jobname
#SBATCH -N 1     #node
#SBATCH --ntasks-per-node=12
#SBATCH --threads-per-core=2
#SBATCH -p bigmem
#SBATCH --mem=30GB

conda activate pilon1.23

cd /home/$USER/scratch/Ga_S_M_M6_2_DNA

trimmomatic PE -summary trim_summary.txt  -threads 12 -phred33 Ga_S_M_M6_2_DNA_UKDSW01699_HGV7FDSXX_L2_1.fq.gz Ga_S_M_M6_2_DNA_UKDSW01699_HGV7FDSXX_L2_2.fq.gz R1_paired_1.fq unpaired1.fastq.gz R2_paired.fq unpaired2.fastq.gz ILLUMINACLIP:~/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:47

