cd /g/steinmetz/hsun/NGLY1/SNV/
#samtools mpileup -uDf /g/steinmetz/hsun/NGLY1/SNV/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.fa 19_AzaC_20uM_biorep1.bam | bcftools view -bvcg - > 19_AzaC_20uM_biorep1.raw.vcf 
bcftools view 19_AzaC_20uM_biorep1.raw.vcf |vcfutils.pl varFilter  > 19_AzaC_20uM_biorep1.flt.vcf
