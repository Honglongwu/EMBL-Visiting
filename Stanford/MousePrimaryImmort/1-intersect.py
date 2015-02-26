def intersect(*F):
    D = {}
    for inF in F:
        inFile = open(inF)
        head = inFile.readline()
        for line in inFile:
            line = line.strip('\n')
            fields = line.split('\t')
            ensembl = fields[0]
            D.setdefault(ensembl, [])
            D[ensembl].append(line)
        inFile.close()
    d = D.items()
    d.sort(cmp = lambda x,y :cmp(float(x[1][0].split('\t')[6]),float(y[1][0].split('\t')[6])))
    for item in d:
        if len(item[1]) == len(F):
            print(item[0] + '\t' + '\t'.join(item[1]))

intersect('de_NGLY1-KO_WT_2014.10.21.sig.ortholog.txt','de_NGLY1-KO_WT_2014.11.10.sig.ortholog.txt')
    
