#!/bin/bash

module load bioinfo-tools
module load bcftools/1.20

bam=$1
outdir=$2

sample="$( cut -d "_" -f1 <<< "${bam}" )"; samplename=${sample##*/}; echo "$samplename"
filebase=$(basename $bam .trimBAM.bam)

bcftools concat ${samplename}/${samplename}_ligate/${filebase}_chr{1..22}.imputed.merged.bcf -Oz -o ${outdir}/${filebase}.all.merged.imputed.vcf.gz
bcftools index -f ${outdir}/${filebase}.all.merged.imputed.vcf.gz
