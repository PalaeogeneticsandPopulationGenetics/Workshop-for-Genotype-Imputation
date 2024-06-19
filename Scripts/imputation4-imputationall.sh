#!/bin/bash

module load bioinfo-tools
module load GLIMPSE/2.0.0

bam=$1

sample="$( cut -d "_" -f1 <<< "${bam}" )"; samplename=${sample##*/}; echo "$samplename"
filebase=$(basename $bam .trimBAM.bam)

pandir=/crex/proj/archaeogenetics/imputation_workshop/reference_panel ###reference panel direction (at Ankara server /mnt/NEOGENE3/share/dna/hsa/genotypes/1000G_20130502/reference_panel)

for chr in {1..22}
do
        REF=${pandir}/split/1000GP.chr${chr}
        VCF=${samplename}/${samplename}_vcf/${filebase}_chr${chr}.vcf.gz
        while IFS="" read -r LINE || [ -n "$LINE" ];
        do
                printf -v ID "%02d" $(echo $LINE | cut -d" " -f1)
                IRG=$(echo $LINE | cut -d" " -f3)
                ORG=$(echo $LINE | cut -d" " -f4)
                CHR=$(echo ${LINE} | cut -d" " -f2)
                REGS=$(echo ${IRG} | cut -d":" -f 2 | cut -d"-" -f1)
                REGE=$(echo ${IRG} | cut -d":" -f 2 | cut -d"-" -f2)
                OUT=${samplename}/${samplename}_impute/${filebase}_chr${chr}_${CHR}_${REGS}_${REGE}.bcf
                GLIMPSE2_phase --input-gl ${VCF} --reference ${REF}_${CHR}_${REGS}_${REGE}.bin --threads 8 --output ${OUT}
        done < chunks.chr${chr}.txt
done
