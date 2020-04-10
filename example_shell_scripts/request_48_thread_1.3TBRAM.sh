#!/bin/bash -l
#SBATCH -J fly_pilon   #jobname
#SBATCH -N 1     #node
#SBATCH --ntasks-per-node=48
#SBATCH --threads-per-core=2
#SBATCH -p bigmem
#SBATCH --nodelist=kennedy150
#SBATCH --mem=1350GB


cd  /home/$USER/scratch/fly_clc

# conda to activate the software
echo $PATH
conda activate pilon1.23

THREADS=48

echo $PATH


PREFIX=fly_ss3.final.scaffolds.fasta

PILITERNUM=1

##################################################
# pilon 1

PILITERNUM=1


bwa index fly_ss3.final.scaffolds.fasta

pigz -d -p $THREADS R1_paired.fq.gz 
pigz -d -p $THREADS R2_paired.fq.gz
bwa mem -t $THREADS  fly_ss3.final.scaffolds.fasta R1_paired.fq R2_paired.fq > new.illumina.mapped.sam

samtools view -@ $THREADS -S -b -o new.illumina.temp.mapped.bam new.illumina.mapped.sam
samtools sort -@ $THREADS -o  new.illumina.mapped.bam new.illumina.temp.mapped.bam

samtools index new.illumina.mapped.bam
rm new.illumina.temp.mapped.bam new.illumina.mapped.sam

# this has been through one iteration. Now use the ouptu from iteration 1 for the new error correction. 
pilon --genome fly_ss3.final.scaffolds.fasta --bam new.illumina.mapped.bam --changes --vcf --diploid --threads $THREADS --output fly_pilon_iter2
