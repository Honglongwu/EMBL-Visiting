inFile = open('NGLY1-unmapped.aligned.paired5.fa.blated')
D = {}
for line in inFile:
    fields = line.split('\t')
    D[fields[0]]=1
inFile.close()

inFile = open('NGLY1-unmapped.aligned.paired5.fa')
ouFile = open('NGLY1-unmapped.aligned.paired6.fa', 'w')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        if line1[1:] not in D:
            ouFile.write(line1 + '\n')
            ouFile.write(line2 + '\n')
    else:
        break
inFile.close()
ouFile.close()
