import sys
import subprocess

CHR = '1'
MIN = 17475
MAX = 18475
bam = sys.argv[1]
ouFile = open(bam+'.chr%s_%s_%s.mpileup'%(CHR,MIN,MAX), 'w')
sp = subprocess.Popen(['samtools', 'mpileup', '-f', '/g/steinmetz/hsun/NGLY1/SNV/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.fa',bam], stdout=subprocess.PIPE, bufsize=1)
for line in sp.stdout:
    fields = line.split('\t')
    if len(fields) > 4:
        if fields[0] == CHR: 
            if MIN <= int(fields[1]) <= MAX:
                ouFile.write(line)
            elif int(fields[1]) >= MAX+1:
                break
ouFile.close()
