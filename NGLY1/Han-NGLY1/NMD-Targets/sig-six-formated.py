CP1 = {}
inFile = open('CP1.six.txt')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split()
    CP1[fields[0]]=[fields[2],fields[-2]]
inFile.close()

CP2 = {}
inFile = open('CP2.six.txt')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split()
    CP2[fields[0]]=[fields[2],fields[-2]]
inFile.close()

CP3 = {}
inFile = open('CP3.six.txt')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split()
    CP3[fields[0]]=[fields[2],fields[-2]]
inFile.close()

CP4 = {}
inFile = open('CP4.six.txt')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split()
    CP4[fields[0]]=[fields[2],fields[-2]]
inFile.close()

MCP1 = {}
inFile = open('MCP1.six.txt')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split()
    MCP1[fields[0]]=[fields[2],fields[-2]]
inFile.close()

FCP1 = {}
inFile = open('FCP1.six.txt')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split()
    FCP1[fields[0]]=[fields[2],fields[-2]]
inFile.close()

RAW= {}
inFile = open('NGLY1-raw-count.txt')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split()
    RAW[fields[0]]=fields[1:]
inFile.close()


ouFile = open('NGLY1-significant-gene-six-individul.txt','w')
for k in RAW:
    ouFile.write(k+'\t'+'\t'.join(RAW[0:4])+'\t'+'\t'.join(CP1[k])+'\t'.join(RAW[4:8])+'\t'.join(CP2[k])+'\t'.join(RAW[8:12])+'\t'.join(CP3[k])+'\t'.join(RAW[12:16])+'\t'.join(CP4[k])
            +'\t'.join(RAW[16:20])+'\t'.join(FCP1[k])+'\t'.join(RAW[20:24])+'\t'.join(MCP1[k]))
ouFile.close()


