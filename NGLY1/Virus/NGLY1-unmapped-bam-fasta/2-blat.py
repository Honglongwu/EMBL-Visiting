import os
DIR = '.'
files = os.listdir(DIR)
for f in files:
    if f.find('.fasta')!=-1:
        ouFile = open(DIR+'/'+f.split('fasta')[0]+'blat.sh','w')
        ouFile.write('#!/bin/bash\n')
        ouFile.write('cd /g/steinmetz/hsun/NGLY1/Virus/NGLY1-unmapped-bam-fasta\n')
        ouFile.write('db=/g/steinmetz/hsun/NGLY1/Genome/HumanUn-and-Viral.fa\n')
        ouFile.write('query='+f+'\n')
        ouFile.write('out=${query}.blated\n')
        #ouFile.write('blastn -db $db -query $query -out $out -outfmt 6\n')
        ouFile.write('blat $db $query -out=blast8 $out\n')
        ouFile.close()
