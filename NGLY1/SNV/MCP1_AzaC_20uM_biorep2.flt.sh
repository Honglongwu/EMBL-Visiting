cd /g/steinmetz/hsun/NGLY1/SNV/
#perl /g/steinmetz/hsun/MySoft/ANNOVAR/annovar/convert2annovar.pl --format vcf4 --includeinfo MCP1_AzaC_20uM_biorep2.flt.vcf >MCP1_AzaC_20uM_biorep2.flt.annovar
#perl /g/steinmetz/hsun/MySoft/ANNOVAR/annovar/annotate_variation.pl -geneanno MCP1_AzaC_20uM_biorep2.flt.annovar  /g/steinmetz/hsun/MySoft/ANNOVAR/annovar/humandb/ --buildver hg19
perl /g/steinmetz/hsun/MySoft/ANNOVAR/annovar/annotate_variation.pl  -filter -dbtype 1000g2012apr_all -maf 0.01 test /g/steinmetz/hsun/MySoft/ANNOVAR/annovar/humandb/ --buildver hg19
