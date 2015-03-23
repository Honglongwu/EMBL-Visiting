import sys
import subprocess

CHR = '3'
MIN = 25760435
MAX = 25831530
bam = sys.argv[1]
ouFile = open(bam+'.chr%s_%s_%s.mpileup'%(CHR,MIN,MAX), 'w')
sp = subprocess.Popen(['samtools', 'mpileup', '-f', '/g/steinmetz/hsun/NGLY1/SNV/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.fa',bam], stdout=subprocess.PIPE, bufsize=1)
#sp = subprocess.Popen('samtools mpileup -uDf /g/steinmetz/hsun/NGLY1/SNV/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.fa %s | bcftools view -'%bam, stdout=subprocess.PIPE, bufsize=1,shell=True)
for line in sp.stdout:
    fields = line.split('\t')
    if len(fields) > 4:
        if fields[0] == CHR: 
            if MIN <= int(fields[1]) <= MAX:
                ouFile.write('\t'.join(fields[0:4]) + '\n')
            elif int(fields[1]) >= MAX+1:
                break
ouFile.close()
