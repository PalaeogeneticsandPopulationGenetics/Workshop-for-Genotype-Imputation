#!/bin/bash

module load bioinfo-tools
module load GLIMPSE/2.0.0
module load bcftools/1.20


bam=$1
chr=$2
sample="$( cut -d "_" -f1 <<< "${bam}" )"; samplename=${sample##*/}; echo "$samplename"
filebase=$(basename $bam .trimBAM.bam)

LST=${samplename}/${samplename}_ligate/list.chr${chr}.txt
ls -1v ${samplename}/${samplename}_impute/${filebase}_chr${chr}_*.*bcf >${LST}
OUT=${samplename}/${samplename}_ligate/${filebase}_chr${chr}.imputed.merged.bcf
GLIMPSE2_ligate --input ${LST} --output ${OUT}
bcftools index -f ${OUT}
