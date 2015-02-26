inFile = open('ngly1_CP1_iPS_LIB18452_RBA17677_1.sam')
D = {}
for line in range(28):
    inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    D.setdefault(fields[1], 0)
    D[fields[1]] += 1
inFile.close()
ouFile = open('ngly1_CP1_iPS_LIB18452_RBA17677_1.sam.mapping', 'w')
for k in D:
    ouFile.write(k + '\t' + str(D[k]) + '\n')
ouFile.close()
