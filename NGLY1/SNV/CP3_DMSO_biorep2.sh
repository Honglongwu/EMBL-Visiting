cd /g/steinmetz/hsun/NGLY1/SNV/
#samtools mpileup -uDf /g/steinmetz/hsun/NGLY1/SNV/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.fa CP3_DMSO_biorep2.bam | bcftools view -bvcg - > CP3_DMSO_biorep2.raw.vcf 
bcftools view CP3_DMSO_biorep2.raw.vcf |vcfutils.pl varFilter  > CP3_DMSO_biorep2.flt.vcf
