import subprocess
import string

trans = string.maketrans('ATCGatcg','TAGCtagc')
inFile = open('NGLY1-unmapped-file-list')
#ouFile = open('NGLY1-unmapped.fasta', 'w')
for line in inFile:
    file = line.strip()
    D = {}
    fd = file.split('/')[-2]
    ouFile = open(fd+'.fasta', 'w')
    sp = subprocess.Popen(['samtools', 'view', file], stdout=subprocess.PIPE, bufsize=1)
    for  x in sp.stdout:
        fields = x.split('\t')
        if fields[9].find('N')==-1:
            if fields[9] not in D and string.translate(fields[9],trans) not in D:
                #ouFile.write('>'+fields[0]+':'+fd+':head'+'\n')
                #ouFile.write(fields[9][0:20]+'\n')
                #ouFile.write('>'+fields[0]+':'+fd+':tail'+'\n')
                #ouFile.write(fields[9][20:]+'\n')
                ouFile.write('>'+fields[0]+':'+fd+'\n')
                ouFile.write(fields[9]+'\n')
                D[fields[9]] = 1

    ouFile.close()
inFile.close()
#ouFile.close()
