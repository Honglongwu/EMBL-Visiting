D = {}
inFile = open('Genes-Interested-TF')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    tf = fields[8]
    gene = fields[0]
    D.setdefault(tf, [])
    D[tf].append(gene)
inFile.close()
d = D.items()
d.sort(cmp = lambda x,y :cmp(len(set(x[1])), len(set(y[1]))),reverse=True)
ouFile = open('Genes-Interested-TF-sorted','w')
for item in d:
    ouFile.write(item[0] +'\t'+ '\t'.join(set(item[1])) + '\n')
ouFile.close()
