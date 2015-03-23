inFile = open('Genes-Interested-TF-sorted')
D = {}
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    D[fields[0]] = 1
inFile.close()

inFile = open('deNGLY1_sig_proteincoding.txt')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    gene = fields[7]
    if gene in D:
        print(gene)
inFile.close()
