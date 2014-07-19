import subprocess
inFile = open('NGLY1-unmapped-file-list')
for line in inFile:
    file = line.strip()
    sp = subprocess.Popen(['samtools', 'view', file], stdout=subprocess.PIPE)
    for  x in sp.stdout:
        fields = x.split('\t')
        print(fields[9])
inFile.close()
