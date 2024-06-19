#!/bin/bash

module load bioinfo-tools
module load samtools

bam=$1 ##prefix
indir=$2
outdir=$3

sample="$( cut -d "_" -f1 <<< "${bam}" )"; samplename=${sample##*/}; echo "$samplename"
filebase=$(basename $bam .trimBAM.bam)

for file in ${indir}/${bam}; do filename=${filebase}; for chrom in `seq 1 22` X Y MT; do samtools view -bh $file ${chrom} > ${outdir}/${samplename}/${samplename}_bam/${filename}_chr${chrom}.bam; done; done

for file in ${outdir}/${samplename}/${samplename}_bam/*.bam; do samtools index $file; done
