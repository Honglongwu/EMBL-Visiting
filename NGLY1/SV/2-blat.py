inFile = open('test')
n = 0
m = 0
L = []
MAX = 100000
while True:
    line1 = inFile.readline()
    line2 = inFile.readline()
    if line1:
        if n < MAX:
            n += 1
            L.append(line1)
            L.append(line2)
        else:
            m += 1
            ouFile = open('test.'+str(m)+'.fa', 'w')
            for x in L:
                ouFile.write(x)
            ouFile.close()
            n = 0
            L = []
            L.append(line1)
            L.append(line2)
    else:
        m += 1
        ouFile = open('test.'+str(m)+'.fa', 'w')
        for x in L:
            ouFile.write(x)
        ouFile.close()
        break
inFile.close()
'''
import os
DIR = '.'
files = os.listdir(DIR)
for f in files:
    if f.find('.fasta')!=-1:
        ouFile = open(DIR+'/'+f.split('fasta')[0]+'blat.sh','w')
        ouFile.write('#!/bin/bash\n')
        ouFile.write('cd /g/steinmetz/hsun/NGLY1/SV\n')
        ouFile.write('db=/g/steinmetz/hsun/NGLY1/Genome/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.viral.fa\n')
        ouFile.write('query='+f+'\n')
        ouFile.write('out=${query}.blated\n')
        #ouFile.write('blastn -db $db -query $query -out $out -outfmt 6\n')
        ouFile.write('blat $db $query -out=blast8 $out\n')
        ouFile.close()
'''
