inFile = open('deNGLY1.txt')
ouFile = open('Human-proteincoding-expressed-genes.txt', 'w')
ouFile2 = open('Human-proteincoding-expressed-genes-symbol.txt', 'w')
ouFile.write('\t'.join(['Ensembl.ID','Gene.Symbol'])+'\n')
S = set()
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    if fields[-1] == 'protein_coding':
        if float(fields[1]) > 20:
            ouFile.write(fields[0] + '\t' + fields[-2]+ '\n')
            S.add(fields[-2])
inFile.close()
ouFile.close()
for k in S:
    ouFile2.write(k + '\n')
ouFile2.close()
