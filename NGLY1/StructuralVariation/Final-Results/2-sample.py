inFile = open('NGLY1-Structural-Variatioin-Candidates-cut5-sample2')
ouFile = open('NGLY1-Structural-Variatioin-Candidates-cut5-sample3', 'w')
D = {}
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    D.setdefault(fields[1], [])
    D[fields[1]].append(line)
inFile.close()
for k in ['EXON','UTR','INTRON']:
    ouFile.write('\n'.join(D[k])+'\n')
ouFile.close()
