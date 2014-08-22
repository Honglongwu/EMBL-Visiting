cd /g/steinmetz/hsun/NGLY1/SNV/
#samtools mpileup -ugDf /g/steinmetz/hsun/NGLY1/SNV/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.fa CP4_AzaC_20uM_biorep2.bam | bcftools view -bvcg - > CP4_AzaC_20uM_biorep2.raw.vcf 
bcftools view CP4_AzaC_20uM_biorep2.raw.vcf |vcfutils.pl varFilter  > CP4_AzaC_20uM_biorep2.flt.vcf
