import subprocess
inFile = open('NGLY1-unmapped-file-list')
for line in inFile:
    file = line.strip()
    sp = subprocess.call(['samtools', 'view', file], stdout=subprocess.PIPE, bufsize=1)
    for  x in sp:
        fields = x.split('\t')
        ouFile.write(fields[0]+'\n')
inFile.close()
