inFile = open('deCP1CP2CP3CP4FCP1MCP1.txt')
ouFile = open('Fibroblast-CP1CP2CP3CP4FCP1MCP1-proteincoding-expressed-genes.txt', 'w')
ouFile.write('\t'.join(['Ensembl.ID','Gene.Symbol'])+'\n')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    if fields[-1] == 'protein_coding':
        if float(fields[1]) > 20:
            ouFile.write(fields[0] + '\t' + fields[-2]+ '\n')
inFile.close()
ouFile.close()
