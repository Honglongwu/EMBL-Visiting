inFile = open('HeLa-identified-peptides-MaxQuant')

D = {}
for line in inFile:
    line = line.strip()
    D[line] = 1
inFile.close()

inFile = open('HeLa-identified-peptides-XTandem')
ouFile = open('HeLa-identified-peptides-both', 'w')
for line in inFile:
    line = line.strip()
    if line in D:
        ouFile.write(line + '\n')
inFile.close()
ouFile.close()
