def ref():
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
    return D
G = ref()
inFile = open('factorbookMotifPos.txt')
D = {}
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    gene = fields[4]
    D.setdefault(gene, [])
    D[gene].append(fields)
inFile.close()
for k in D:
    if k in G:
        pass
    else:
        print(k)

'''
inFile = open('Genes-Will-Pos')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    gene = fields[0]
    if gene in D:
        print(gene)
inFile.close()
'''
