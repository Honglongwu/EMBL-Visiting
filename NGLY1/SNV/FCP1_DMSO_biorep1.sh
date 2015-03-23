cd /g/steinmetz/hsun/NGLY1/SNV/
#samtools mpileup -uDf /g/steinmetz/hsun/NGLY1/SNV/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.fa FCP1_DMSO_biorep1.bam | bcftools view -bvcg - > FCP1_DMSO_biorep1.raw.vcf 
bcftools view FCP1_DMSO_biorep1.raw.vcf |vcfutils.pl varFilter  > FCP1_DMSO_biorep1.flt.vcf
