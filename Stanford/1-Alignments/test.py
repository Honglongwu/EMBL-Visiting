inFile = open('sampleAnnot-2014-11-10.txt')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    print(fields[-1])
inFile.close()
