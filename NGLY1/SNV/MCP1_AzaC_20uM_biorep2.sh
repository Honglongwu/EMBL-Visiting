cd /g/steinmetz/hsun/NGLY1/SNV/
#samtools mpileup -uDf /g/steinmetz/hsun/NGLY1/SNV/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.fa MCP1_AzaC_20uM_biorep2.bam | bcftools view -bvcg - > MCP1_AzaC_20uM_biorep2.raw.vcf 
bcftools view MCP1_AzaC_20uM_biorep2.raw.vcf |vcfutils.pl varFilter  > MCP1_AzaC_20uM_biorep2.flt.vcf
