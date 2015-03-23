import os
Fs = os.listdir('.')
for F in Fs:
    if F[-4:] == '.bam':
        ouFile = open(F + '.mpileup.sh', 'w')
        ouFile.write('cd /g/steinmetz/hsun/NGLY1/SNV\n')
        ouFile.write('python 5-mpileup.py %s\n'%F)
        ouFile.close()
