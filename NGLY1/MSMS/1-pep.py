D = {}
inFile = open('/g/steinmetz/hsun/NGLY1/MSMS/NGLY1-peptide/NGLY1-protein-Uniprot.fa')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        D.setdefault(line2,[line1])
    else:
        break
inFile.close()

inFile = open('evidence.txt')
for line in inFile:
    fields = line.split('\t')
    pep=fields[0]
    for k in  D:
        if pep in k:
            D[k].append([pep,line])
inFile.close()
for k in D:
    if len(D[k]) > 1:
        for x in D[k][1:]:
            print(x[0] + '\t' + x[1])
