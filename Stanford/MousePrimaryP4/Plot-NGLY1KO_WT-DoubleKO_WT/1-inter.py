D = {}
inFile = open('de_Double-KO_WT_2014.10.21.sig.ortholog.txt')
head = inFile.readline()
for line in inFile:
    fields = line.split('\t')
    D[fields[0]] = fields[7]
inFile.close()

inFile = open('de_NGLY1-KO_WT.sig.ortholog.proteincoding.txt')
head = inFile.readline()
for line in inFile:
    gene = line.split('\t')[0]
    if gene in D:
        print(D[gene])
inFile.close()
