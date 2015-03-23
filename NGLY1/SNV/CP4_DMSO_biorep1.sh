cd /g/steinmetz/hsun/NGLY1/SNV/
samtools mpileup -ugDf /g/steinmetz/hsun/NGLY1/SNV/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.fa CP4_DMSO_biorep1.bam | bcftools view -bvcg - > CP4_DMSO_biorep1.raw.vcf 
bcftools view CP4_DMSO_biorep1.raw.vcf |vcfutils.pl varFilter  > CP4_DMSO_biorep1.flt.vcf
