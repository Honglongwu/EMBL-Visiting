D = {}
inFile = open('/g/steinmetz/hsun/Stanford/data/Ensembl/Ortholog-Human-Mouse.txt')
for line in inFile:
    line = line.rstrip()
    fields = line.split('\t')
    mouse = fields[3]
    D.setdefault(mouse, [])
    if D[mouse]:
        pass
    else:
        D[mouse].append('\t'.join([fields[1], fields[0]]))
inFile.close()


def express(inF, ouF):
    inFile = open(inF)
    ouFile = open(ouF, 'w')
    S2 = set()
    S3 = set()
    S4 = set()
    ouFile2 = open(ouF.split('.txt')[0]+'.symbol.txt', 'w')
    ouFile3 = open(ouF.split('.txt')[0]+'.symbol.up.txt', 'w')
    ouFile4 = open(ouF.split('.txt')[0]+'.symbol.down.txt', 'w')

    ouFile.write('\t'.join(['Mouse.Ensembl.ID','Mouse.Gene.Symbol','Human.Ensembl.ID','Human.Gene.Symbol'])+ '\n')
    head = inFile.readline()
    for line in inFile:
        line = line.strip()
        fields = line.split('\t')
        if fields[-1] == 'protein_coding':
            if float(fields[1]) > 20:
                S2.add(fields[-2])
                if float(fields[2]) >=0 :
                    S3.add(fields[-2])
                else:
                    S4.add(fields[-2])
                if fields[0] in D:
                    ouFile.write(fields[0] + '\t' + fields[-2] + '\t' + '\t'.join(D[fields[0]])+ '\n')
                else:
                    ouFile.write(fields[0] + '\t' + fields[-2] + '\t\t' + '\n')
    for s in S2:
        ouFile2.write(s + '\n')
    for s in S3:
        ouFile3.write(s + '\n')
    for s in S4:
        ouFile4.write(s + '\n')
    inFile.close()
    ouFile.close()
    ouFile2.close()
    ouFile3.close()
    ouFile4.close()

express('de_NGLY1-KO_WT.txt','NGLY1-KO_WT_proteincoding-expressed-genes.txt')
