import subprocess
inFile = open('NGLY1-unmapped-file-list')
for line in inFile:
    file = line.strip()
    fd = file.split('/')
    ouFile = open(fd[-2]+'.fasta', 'w')
    sp = subprocess.Popen(['samtools', 'view', file], stdout=subprocess.PIPE, bufsize=1)
    for  x in sp.stdout:
        fields = x.split('\t')
        ouFile.write('>'+fields[0]+'\n')
        ouFile.write(fields[9]+'\n')
    ouFile.close()
inFile.close()
