inFile = open('de_NGLY1-KO_WT.txt')
D = {}
head = inFile.readline()
for line in inFile:
    fields = line.split('\t')
    D.setdefault(fields[0], [])
    D[fields[0]].append(fields[2])
inFile.close()

inFile = open('de_Double-KO_WT_2014.10.21.txt')
head = inFile.readline()
for line in inFile:
    fields = line.split('\t')
    D.setdefault(fields[0], [])
    D[fields[0]].append(fields[2])
inFile.close()

ouFile = open('NGLY1-KO_WT_Double-KO_WT_foldchange','w')
for k in D:
    if 'NA' not in D[k]:
        ouFile.write(k + '\t' + '\t'.join(D[k]) + '\n')
ouFile.close()
