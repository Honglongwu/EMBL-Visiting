inFile = open('BIOGRID-ALL-3.3.122.tab2.txt')
ouFile = open('BIOGRID-ALL-Interaction', 'w')
D = {}
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    gene1 = fields[7].strip()
    gene2 = fields[8].strip()
    if fields[15] == '9606' and fields[16] == '9606' and gene1 != 'NA' and gene2 != 'NA':
        k1 = gene1 + '\t' + gene2
        k2 = gene2 + '\t' + gene1
        if k1 not in D and k2 not in D:
            D.setdefault(k1, 0)
            D[k1] += 1
        elif k1 in D:
            D[k1] += 1
        elif k2 in D:
            D[k2] += 1
inFile.close()
for k in D:
    ouFile.write(k + '\n')
ouFile.close()
