def intersect(inF1, inF2, ouF):
    D = {}
    L = []
    inFile = open(inF1)
    head = inFile.readline().strip('\n')
    for line in inFile:
        line = line.strip('\n')
        fields = line.split('\t')
        gene = fields[0]
        D.setdefault(gene, [])
        D[gene].append(line)
        L.append(gene)
    inFile.close()

    inFile = open(inF2)
    head = inFile.readline().strip('\n')
    for line in inFile:
        line = line.strip('\n')
        fields = line.split('\t')
        gene = fields[0]
        D.setdefault(gene, [])
        D[gene].append(line)
    inFile.close()

    ouFile = open(ouF, 'w')
    for k in L:
        if len(D[k]) == 2:
            ouFile.write('\t'.join(D[k]) + '\n')
    ouFile.close()

inF1 = 'deCP1CP2CP3CP4FCP1MCP1_sig_proteincoding_up.txt'
inF2 = 'deCP1CP3MCP1Ctrl_sig_proteincoding_up.txt'
ouF = 'Human-Fibroblast-Lymphoblast-sig-proteincoding-up.txt'
intersect(inF1, inF2, ouF)

inF1 = 'deCP1CP2CP3CP4FCP1MCP1_sig_proteincoding_down.txt'
inF2 = 'deCP1CP3MCP1Ctrl_sig_proteincoding_down.txt'
ouF = 'Human-Fibroblast-Lymphoblast-sig-proteincoding-down.txt'
intersect(inF1, inF2, ouF)
