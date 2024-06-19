#!/bin/bash

module load bioinfo-tools
module load GLIMPSE/2.0.0


chr=$1
#VCF=NA12878_1x_vcf/NA12878.chr22.1x.vcf.gz
pandir=/crex/proj/archaeogenetics/imputation_workshop/reference_panel  ###direction of 1000G reference panel (at Ankara server /mnt/NEOGENE3/share/dna/hsa/genotypes/1000G_20130502/reference_panel)
mapdir=/crex/proj/archaeogenetics/imputation_workshop/maps/genetic_maps.b37  ###direction of thr genetic maps file from GLIMPSE sw file (at Ankara server /usr/local/sw/GLIMPSE/maps/genetic_maps.b37)

REF=${pandir}/1000GP.chr${chr}.bcf
MAP=${mapdir}/chr${chr}.b37.gmap.gz

mkdir -p ${pandir}/split

while IFS="" read -r LINE || [ -n "$LINE" ];
do
  printf -v ID "%02d" $(echo $LINE | cut -d" " -f1)
  IRG=$(echo $LINE | cut -d" " -f3)
  ORG=$(echo $LINE | cut -d" " -f4)
  GLIMPSE2_split_reference --reference ${REF} --map ${MAP} --input-region ${IRG} --output-region ${ORG} --output ${pandir}/split/1000GP.chr${chr}
done < chunks.chr${chr}.txt
