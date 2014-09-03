import subprocess
import string
trans = string.maketrans('ATCGatcg','TAGCtagc')

inFile = open('NGLY1-unmapped-file-list2')
ouFile = open('NGLY1-unmapped.fq', 'w')
D = {}
for line in inFile:
    file = line.strip()
    fd = file.split('/')[-2]
    #ouFile = open(fd+'.fasta', 'w')
    sp = subprocess.Popen(['samtools', 'view', file], stdout=subprocess.PIPE, bufsize=1)
    for  x in sp.stdout:
        fields = x.split('\t')
        if fields[9].find('N')==-1:
            seq = fields[9]
            seq_rev = string.translate(fields[9],trans)
            if seq in D: 
                D[seq].append(fd+':'+fields[0])
            elif seq_rev in D:
                D[seq_rev].append(fd+':'+fields[0])
            else:
                D.setdefault(seq, [fd+':'+fields[0]])
    #ouFile.close()
inFile.close()
for k in D:
    ouFile.write('@' + '|'.join(D[k]) +'|'+k+'|'+'1'+ '\n')
    ouFile.write(k[0:24] + '\n')
    ouFile.write('+\n')
    ouFile.write('H'*len(k[0:24])+'\n')
    ouFile.write('@' + '|'.join(D[k]) +'|'+k+'|'+'2'+ '\n')
    ouFile.write(k[24:] + '\n')
    ouFile.write('H'*len(k[24:])+'\n')
ouFile.close()
