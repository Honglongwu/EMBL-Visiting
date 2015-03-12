inFile = open('Genes-Interested-TF')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    tf = fields[]
    gene = fields[]

inFile.close()
