D = {}
inFile = open('NGLY1-unmapped.aligned.paired3')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    D[fields[0]] = 1
inFile.close()
inFile = open('NGLY1-unmapped.aligned.paired3-1')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    if fields[0] not in D:
        print(line)
inFile.close()
