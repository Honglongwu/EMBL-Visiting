cd /g/steinmetz/hsun/NGLY1/SNV/
#samtools mpileup -uDf /g/steinmetz/hsun/NGLY1/SNV/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.fa CP2_AzaC_20uM_biorep1.bam | bcftools view -bvcg - > CP2_AzaC_20uM_biorep1.raw.vcf 
bcftools view CP2_AzaC_20uM_biorep1.raw.vcf |vcfutils.pl varFilter  > CP2_AzaC_20uM_biorep1.flt.vcf
