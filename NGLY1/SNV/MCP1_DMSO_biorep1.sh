cd /g/steinmetz/hsun/NGLY1/SNV/
#samtools mpileup -uDf /g/steinmetz/hsun/NGLY1/SNV/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.fa MCP1_DMSO_biorep1.bam | bcftools view -bvcg - > MCP1_DMSO_biorep1.raw.vcf 
bcftools view MCP1_DMSO_biorep1.raw.vcf |vcfutils.pl varFilter  > MCP1_DMSO_biorep1.flt.vcf
