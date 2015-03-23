inFile = open('NGLY1-unmapped.aligned.paired5.blated')
D = {}
for line in inFile:
    fields = line.split('\t')
    D[fields[0]]=1
inFile.close()

inFile = open('NGLY1-unmapped.aligned.paired5')
ouFile = open('NGLY1-unmapped.aligned.paired6', 'w')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        #if line1[1:] not in D and line1.find('Un')==-1 and line1.find('gi') == -1 and line1.find('andom')==-1:
        if line1[1:] not in D:
            ch = [str(x) for x in range(1,23)] + ['X','Y']
            fields = line1.split('_')
            if fields[1] in ch and fields[3] in ch:
                ouFile.write(line1 + '\n')
                ouFile.write(line2 + '\n')
    else:
        break
inFile.close()
ouFile.close()
