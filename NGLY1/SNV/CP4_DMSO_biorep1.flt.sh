cd /g/steinmetz/hsun/NGLY1/SNV/
perl /g/steinmetz/hsun/MySoft/ANNOVAR/annovar/convert2annovar.pl --format vcf4 --includeinfo CP4_DMSO_biorep1.flt.vcf >CP4_DMSO_biorep1.flt.annovar
perl /g/steinmetz/hsun/MySoft/ANNOVAR/annovar/annotate_variation.pl -geneanno CP4_DMSO_biorep1.flt.annovar  /g/steinmetz/hsun/MySoft/ANNOVAR/annovar/humandb/ --buildver hg19
