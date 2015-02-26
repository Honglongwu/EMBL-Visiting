D = {}
inFile = open('/g/steinmetz/hsun/Stanford/data/Ensembl/Ortholog-Human-Mouse.txt')
for line in inFile:
    line = line.rstrip()
    fields = line.split('\t')
    mouse = fields[3]
    D.setdefault(mouse, [])
    D[mouse].append('\t'.join([fields[1], fields[0]]))
inFile.close()

def ortholog(inF):
    inFile = open(inF)
    ouFile = open(inF.split('.txt')[0] + '.ortholog.txt','w')
    head = inFile.readline().rstrip()
    ouFile.write(head + '\thuman_ensembl\thuman_symbol\n')
    for line in inFile:
        line = line.strip()
        fields = line.split('\t')
        mouse = fields[0]
        if mouse in D:
            ouFile.write(line + '\t' + D[mouse][0] + '\n')
        else:
            ouFile.write(line + '\t' + '' + '\n')
    inFile.close()
    ouFile.close()

    
ortholog('de_NGLY1-KO_WT.sig.txt')
