D = {}
inFile = open('NGLY1-unmapped.aligned')
ouFile = open('NGLY1-unmapped.aligned.paired', 'w')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    k = fields[0].split('|')[0]
    D.setdefault(k,[])
    D[k].append(line)
inFile.close()
for k in D:
    if len(D[k])==2:
        ouFile.write(D[k][0]+'\n')
        ouFile.write(D[k][1]+'\n')
ouFile.close()
