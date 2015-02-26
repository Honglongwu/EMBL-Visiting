import os
ouFile = open('merge-mouse-primaryP4.sh', 'w')
Fs = os.listdir('.')
D = {}
for F in Fs:
    if F.find('_2014.') != -1:
        sample = F.split('_2014')[0]
        D[sample] = 1
for sample in D:
    ouFile.write('samtools merge -r -@ 10 -1 %s %s %s'%(sample+'.bam', sample+'_2014.10.21.bam', sample+'_2014.11.10.bam') + '\n')
    ouFile.write('samtools index %s'%sample+'.bam' + '\n')
ouFile.close()    



'''
Double-KO_biorep1_primaryP4_2014.10.21.bam
Double-KO_biorep2_primaryP4_2014.10.21.bam
Double-KO_biorep2_primaryP4_2014.11.10.bam
ENGase-KO_biorep1_primaryP4_2014.10.21.bam
NGLY1-KO_biorep1_primaryP4_2014.10.21.bam
NGLY1-KO_biorep1_primaryP4_2014.11.10.bam
NGLY1-KO_biorep2_primaryP4_2014.10.21.bam
NGLY1-KO_biorep2_primaryP4_2014.11.10.bam
NGLY1-KO_biorep3_primaryP4_2014.10.21.bam
NGLY1-KO_biorep3_primaryP4_2014.11.10.bam
WT_biorep1_primaryP4_2014.10.21.bam
WT_biorep1_primaryP4_2014.11.10.bam
WT_biorep2_primaryP4_2014.10.21.bam
WT_biorep2_primaryP4_2014.11.10.bam
WT_biorep3_primaryP4_2014.10.21.bam
WT_biorep3_primaryP4_2014.11.10.bam
'''
