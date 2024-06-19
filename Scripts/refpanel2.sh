#!/bin/bash

###### slurm Options ###########################

### Job name
#SBATCH --job-name=chunk

### Planned time
#SBATCH -t 230:00:00

### Node and memory information

#SBATCH -p core -n 1

### User and project


#SBATCH -A naiss2024-5-42
####################################################################

############################ FOLDERS ###############################

### Select the proper folders for clusters

### rackham

echo '########################################'
echo 'Date:' $(date --iso-8601=seconds)
echo 'User:' $USER
echo 'Host:' $HOSTNAME
echo 'Job Name:' $SLURM_JOB_NAME
echo 'Job Id:' $SLURM_JOB_ID
echo 'Directory:' $(pwd)
scontrol show job $SLURM_JOB_ID
echo '########################################'

module load bioinfo-tools
module load GLIMPSE/2.0.0

chr=$1
outdir=$2

pandir=/crex/proj/archaeogenetics/imputation_workshop/reference_panel  ### direction of the reference panel file (at Ankara server /mnt/NEOGENE3/share/dna/hsa/genotypes/1000G_20130502/reference_panel)
mapdir=/crex/proj/archaeogenetics/imputation_workshop/maps/genetic_maps.b37 ### direction of thr genetic maps file from GLIMPSE sw file (at Ankara server /usr/local/sw/GLIMPSE/maps/genetic_maps.b37)

GLIMPSE2_chunk --input ${pandir}/1000GP.chr${chr}.sites.vcf.gz --region ${chr} --sequential --output ${outdir}/chunks.chr${chr}.txt --map ${mapdir}/chr${chr}.b37.gmap.gz
