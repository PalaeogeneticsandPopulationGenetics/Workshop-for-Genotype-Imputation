#!/bin/bash

module load bioinfo-tools
module load bcftools/1.20
module load tabix/0.2.6

bam=$1 ##AKT16_merged.hs37d5.cons.90perc.down_chr
chr=$2
sample="$( cut -d "_" -f1 <<< "${bam}" )"; samplename=${sample##*/}; echo "$samplename"
filebase=$(basename $bam .trimBAM.bam)

refdir=/crex/proj/archaeogenetics/imputation_workshop/ref                  ###reference genome direction /mnt/NEOGENE4/projects/kivilcim_2022/reference_genome
pandir=/crex/proj/archaeogenetics/imputation_workshop/reference_panel      ###reference panel direction 

BAM=${samplename}/${samplename}_bam/${filebase}_chr${chr}.bam
REFGEN=${refdir}/hs37d5.chr${chr}.fa
VCF=${pandir}/1000GP.chr${chr}.sites.vcf.gz
TSV=${pandir}/1000GP.chr${chr}.sites.tsv.gz
OUT=${samplename}/${samplename}_vcf/${filebase}_chr${chr}.vcf.gz

bcftools mpileup -f ${REFGEN} -I -E -a 'FORMAT/DP' -T ${VCF} -r ${chr} -q 30 -Q 30 ${BAM}  -Ou | bcftools call -Aim -C alleles -T ${TSV} -Oz -o ${OUT}
bcftools index -f ${OUT}
