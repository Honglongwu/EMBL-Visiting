cd /g/steinmetz/hsun/NGLY1/SNV/
#perl /g/steinmetz/hsun/MySoft/ANNOVAR/annovar/convert2annovar.pl --format vcf4 --includeinfo CP3_DMSO_biorep2.flt.vcf >CP3_DMSO_biorep2.flt.annovar
perl /g/steinmetz/hsun/MySoft/ANNOVAR/annovar/annotate_variation.pl -geneanno CP3_DMSO_biorep2.flt.annovar  /g/steinmetz/hsun/MySoft/ANNOVAR/annovar/humandb/ --buildver hg19
