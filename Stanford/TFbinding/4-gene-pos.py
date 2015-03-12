inFile = open('hg19_refGene.txt')
D = {}
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    gene = fields[12]
    strand = fields[3]
    ch = fields[2]
    start = fields[4]
    end = fields[5]
    D.setdefault(gene, [])
    D[gene].append([gene,ch,strand,start,end])
inFile.close()


inFile = open('Genes-Interested')
ouFile = open('Genes-Interested-Pos', 'w')
for line in inFile:
    line = line.strip()
    gene = line
    if gene in D:
        ouFile.write('\t'.join(D[gene][0]) + '\n')
inFile.close()
ouFile.close()
