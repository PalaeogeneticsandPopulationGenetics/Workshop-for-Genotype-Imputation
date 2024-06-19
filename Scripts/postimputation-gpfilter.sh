#!/bin/bash
module load bioinfo-tools
module load bcftools/1.20

bam=$1
indir=$2
outdir=$3

sample="$(cut -d "_" -f1 <<< "${bam}" )"; samplename=${sample##*/}; echo "$samplename"
filebase=$(basename $bam .trimBAM.bam)

bcftools view -i 'FORMAT/GP>=0.99' ${indir}/${filebase}.all.merged.imputed.vcf.gz -Oz -o ${outdir}/${filebase}.all.merged.imputed.GP99.vcf.gz
bcftools index -f ${outdir}/${filebase}.all.merged.imputed.GP99.vcf.gz
