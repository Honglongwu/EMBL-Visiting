D = {}
Protein = {}
inFile = open('peptides.txt')
header = inFile.readline()
for line in inFile:
    fields = line.split('\t')
    D[fields[0]] = 1
inFile.close()

inFile = open('NGLY1-protein-Uniprot.fa')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        for k in D:
            if k in line2:
                s = line1 + '\n' + line2
                Protein.setdefault(s, [])
                Protein[s].append(k)
    else:
        break
inFile.close()

for k in Protein:
    print(k)
    print('\t'.join(Protein[k]))

