def pep(inF):
    inFile = open(inF)
    
    D = {}
    for line in inFile:
        line = line.strip()
        fields = line.split('\t')
        pep = fields[4]
        D.setdefault(pep, []) 
        D[pep].append(line)
    inFile.close()

    d = D.items()
    d.sort(cmp = lambda x,y:cmp(len(x[1]), len(y[1])), reverse=True)
    
    ouFile = open(inF + '-pep','w')
    for item in d:
        ouFile.write(item[0]+'\t'+str(len(item[1]))+'\t'+'\t'.join(item[1])+'\n')
    ouFile.close()

pep('Yeast-peptide-sixFrame')
