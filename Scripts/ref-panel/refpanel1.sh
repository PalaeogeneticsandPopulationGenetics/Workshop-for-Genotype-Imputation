#!/bin/bash

module load bioinfo-tools
module load bcftools/1.20
module load tabix/0.2.6

chr=$1
outdir=$2


wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr${chr}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz{,.tbi}


bcftools norm -m -any ALL.chr${chr}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz -Ou --threads 4 | bcftools view -m 2 -M 2 -v snps --threads 4 -Ob -o ${outdir}/reference_panel/1000GP.chr${chr}.bcf 
bcftools index -f ${outdir}/reference_panel/1000GP.chr${chr}.bcf --threads 4

bcftools view -G -m 2 -M 2 -v snps ${outdir}/reference_panel/1000GP.chr${chr}.bcf -Oz -o ${outdir}/reference_panel/1000GP.chr${chr}.sites.vcf.gz
bcftools index -f ${outdir}/reference_panel/1000GP.chr${chr}.sites.vcf.gz

##for GLIMPSE1, If you will use GLIMPSE2 this step is not mandatory
bcftools query -f'%CHROM\t%POS\t%REF,%ALT\n' ${outdir}/reference_panel/1000GP.chr${chr}.sites.vcf.gz | bgzip -c > ${outdir}/reference_panel/1000GP.chr${chr}.sites.tsv.gz
tabix -s1 -b2 -e2 ${outdir}/reference_panel/1000GP.chr${chr}.sites.tsv.gz
