#!/bin/bash
module load bioinfo-tools
module load bcftools/1.20

list=$1   #####ls *.vcf>list
datasetname=$2

bcftools merge -l ${list} -Oz -o ${datasetname}.all.vcf.gz
bcftools index -f ${datasetname}.all.vcf.gz
