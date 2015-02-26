F = {}
L = {}
M = {}
UCEC = {}
SKM = {}

inFile = open('deFibroblast_sig_proteincoding.txt')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    F.append(fields[0])

inFile.close()
