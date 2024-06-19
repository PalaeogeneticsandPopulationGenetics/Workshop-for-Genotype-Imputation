#!/bin/bash
#Not a mandatory step

module load bioinfo-tools
module load picard/3.1.1
module load samtools

bam=$1
indir=$2
outdir=$3

sample="$( cut -d "_" -f1 <<< "${bam}" )"; samplename=${sample##*/}; echo "$samplename"
filebase=$(basename $bam .bam)

###Add read group to bam
java -jar $PICARD AddOrReplaceReadGroups I=${indir}/${filebase}.bam O=${outdir}/${filebase}.bam SORT_ORDER=coordinate RGID=foo RGLB=bar RGPU=foo RGPL=illumina RGSM=${samplename} CREATE_INDEX=True

samtools index ${outdir}/${filebase}.bam
