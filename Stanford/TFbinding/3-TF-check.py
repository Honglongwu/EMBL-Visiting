inFile = open('Ensembl-Binding')
content = inFile.read()
inFile.close()

inFile = open('Genes-Will-Pos')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    gene = fields[0]
    if gene in content:
        print(gene)
inFile.close()
