inFile = open('deIPS.txt')
ouFile = open('IPS-proteincoding-expressed-genes.txt', 'w')
ouFile2 = open('IPS-proteincoding-expressed-genes2.txt', 'w')
ouFile.write('\t'.join(['Ensembl.ID','Gene.Symbol'])+'\n')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    if fields[-1] == 'protein_coding':
        if float(fields[1]) > 20:
            ouFile.write(fields[0] + '\t' + fields[-2]+ '\n')
            ouFile2.write( fields[-2]+ '\n')
inFile.close()
ouFile.close()
