#!/bin/bash

###creating the files 

for bam in $(cat bamlist1);do sample="$( cut -d "_" -f1 <<< "${bam}" )"; samplename=${sample##*/}; echo "$samplename";done >list
for i in $(cat list);do mkdir ${i};done
for i in $(cat list);do mkdir ${i}/${i}_bam;done
for i in $(cat list);do mkdir ${i}/${i}_vcf;done
for i in $(cat list);do mkdir ${i}/${i}_impute;done
for i in $(cat list);do mkdir ${i}/${i}_ligate;done
