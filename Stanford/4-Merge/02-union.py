def union(inF1, inF2, inF3, ouF):
    D = {}
    L = []
    inFile = open(inF1)
    for line in inFile:
        line = line.rstrip()
        fields = line.split('\t')
        D.setdefault(fields[0],[])
        D[fields[0]].append(line)
        if fields[0] not in L:
            L.append(fields[0])
    inFile.close()
    inFile = open(inF2)
    for line in inFile:
        line = line.rstrip()
        fields = line.split('\t')
        D.setdefault(fields[0],[])
        D[fields[0]].append(line)
        if fields[0] not in L:
            L.append(fields[0])
    inFile.close()
    inFile = open(inF3)
    for line in inFile:
        line = line.rstrip()
        fields = line.split('\t')
        D.setdefault(fields[0],[])
        D[fields[0]].append(line)
        if fields[0] not in L:
            L.append(fields[0])
    inFile.close()
    ouFile = open(ouF, 'w')
    for k in L:
        ouFile.write('\t'.join(D[k]) + '\n')

    ouFile.close()

union('de_NGLY1-KO_WT_2014.10.21.sig.ortholog.human.down.txt','de_NGLY1-KO_WT_2014.11.10.sig.ortholog.human.down.txt','de_NGLY1-KO_WT_immortP5.sig.ortholog.human.down.txt','de_NGLY1-KO_WT_human_ortholog_down.txt')
union('de_NGLY1-KO_WT_2014.10.21.sig.ortholog.human.up.txt','de_NGLY1-KO_WT_2014.11.10.sig.ortholog.human.up.txt','de_NGLY1-KO_WT_immortP5.sig.ortholog.human.up.txt','de_NGLY1-KO_WT_human_ortholog_up.txt')
