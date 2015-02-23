import os
Fs = os.listdir('.')
D = {}
for F in Fs:
    if F.find('_primaryP4_2014') != -1:
        sample = F.split('_primaryP4_2014')[0]
        D[sample] = 1
for sample in D:
    print('samtools merge %s %s %s'%(sample+'.bam', sample+'_primaryP4_2014.10.21.bam', sample+'_primaryP4_2014.11.10.bam'))



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
