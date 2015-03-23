import os
Fs = os.listdir('.')
for F in Fs:
    if F[-8:] == '.flt.vcf':
        ouPrefix = F[0:-4]
        ouFile = open(ouPrefix+'.sh', 'w')
        ouFile.write('cd /g/steinmetz/hsun/NGLY1/SNV/\n')
        ouFile.write('#perl /g/steinmetz/hsun/MySoft/ANNOVAR/annovar/convert2annovar.pl --format vcf4 --includeinfo %s.vcf >%s.annovar\n'%(ouPrefix,ouPrefix))
        ouFile.write('perl /g/steinmetz/hsun/MySoft/ANNOVAR/annovar/annotate_variation.pl -geneanno %s.annovar  /g/steinmetz/hsun/MySoft/ANNOVAR/annovar/humandb/ --buildver hg19\n' %ouPrefix)
        ouFile.close()

