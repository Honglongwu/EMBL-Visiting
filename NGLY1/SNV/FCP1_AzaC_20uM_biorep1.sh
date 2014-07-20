cd /g/steinmetz/hsun/NGLY1/SNV/alignment_filtered
#samtools mpileup -uDf /g/steinmetz/hsun/NGLY1/SNV/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.fa FCP1_AzaC_20uM_biorep1.bam | bcftools view -bvcg - > FCP1_AzaC_20uM_biorep1.raw.vcf 
bcftools view FCP1_AzaC_20uM_biorep1.raw.vcf |/g/steinmetz/hsun/MySoft/samtools/samtools-0.1.19/bcftools/vcfutils.pl varFilter - > FCP1_AzaC_20uM_biorep1.flt.vcf
