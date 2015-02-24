def intersect(inF1, inF2, ouF):
    D = {}
    L = []
    inFile = open(inF1)
    head = inFile.readline().strip('\n')
    for line in inFile:
        line = line.rstrip()
        fields = line.split('\t')
        gene = fields[0]
        D.setdefault(gene, [])
        D[gene].append(line)
        L.append(gene)
    inFile.close()

    inFile = open(inF2)
    head = inFile.readline().strip('\n')
    for line in inFile:
        line = line.rstrip()
        fields = line.split('\t')
        gene = fields[-2]
        D.setdefault(gene, [])
        D[gene].append(line)
    inFile.close()

    ouFile = open(ouF, 'w')
    for k in L:
        if len(D[k]) == 2:
            ouFile.write('\t'.join(D[k]) + '\n')
    ouFile.close()

inF1 = 'deFibroblast_sig_proteincoding_down.txt'
inF2 = 'de_NGLY1-KO_WT.sig.ortholog.proteincoding.human.down.txt'
ouF = 'Human-Fibroblast-Mouse-sig-proteincoding-down.txt'
intersect(inF1, inF2, ouF)

inF1 = 'deFibroblast_sig_proteincoding_up.txt'
inF2 = 'de_NGLY1-KO_WT.sig.ortholog.proteincoding.human.up.txt'
ouF = 'Human-Fibroblast-Mouse-sig-proteincoding-up.txt'
intersect(inF1, inF2, ouF)
