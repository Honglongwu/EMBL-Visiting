D = {}
inFile = open('HeLa-Predict-both')
for line in inFile:
    line = line.strip()
    D[line] = 1
inFile.close()

Protein = {}
inFile = open('Homo_sapiens.GRCh37.70.pep.abinitio.fa.fa')
ouFile = open('Homo_sapiens.GRCh37.70.pep.abinitio-peptides-num', 'w')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        Protein.setdefault(line2, 0)
        for k in D:
            if k in line2:
                Protein[line2] += 1
    else:
        break
inFile.close()

for k in Protein:
    if Protein[k] >0:
        ouFile.write(k + '\t' + str(Protein[k])+ '\n')
ouFile.close()
