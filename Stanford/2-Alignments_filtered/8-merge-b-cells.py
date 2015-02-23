import os
Fs = os.listdir('.')
ouFile = open('merge-Bcells.sh', 'w')
for F in Fs:
    if F[-10:]=='_lane3.bam':
        f1 = '/g/steinmetz/hsun/NGLY1/NGLY1-wmueller/alignment_filtered/B-Cells/'+F.split('_lane3.bam')[0]+'.bam'
        f2 = F
        f3 = F.split('_lane3.bam')[0]+'.bam'
        ouFile.write('samtools merge -r -@ 10 -1 %s %s %s'%(f3,f1,f2) + '\n')
        ouFile.write('samtools index %s\n'%f3)
ouFile.close()
    
