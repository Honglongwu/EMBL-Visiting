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

inFile = open('Genes-Will')
for line in inFile:
    line = line.strip()
    gene = line
    if gene in D:
        print(set(D[gene]))
inFile.close()
