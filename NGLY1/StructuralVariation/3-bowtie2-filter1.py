inFile = open('NGLY1-unmapped.sam')
ouFile = open('NGLY1-unmapped.aligned', 'w')
for line in range(32):
    inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    if fields[1] != '4':
        ouFile.write(line+'\n')
inFile.close()
ouFile.close()
