cd /g/steinmetz/hsun/NGLY1/SNV/alignment_filtered
#samtools mpileup -uDf /g/steinmetz/hsun/NGLY1/SNV/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.fa CP2_DMSO_biorep2.bam | bcftools view -bvcg - > CP2_DMSO_biorep2.raw.vcf 
bcftools view CP2_DMSO_biorep2.raw.vcf |/g/steinmetz/hsun/MySoft/samtools/samtools-0.1.19/bcftools/vcfutils.pl varFilter - > CP2_DMSO_biorep2.flt.vcf
