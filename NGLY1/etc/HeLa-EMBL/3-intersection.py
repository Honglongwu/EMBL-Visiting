inFile = open('HeLa-Predict-MaxQuant')

D = {}
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    D[fields[2]] = 1
inFile.close()

inFile = open('HeLa-Predict-XTandem')
ouFile = open('HeLa-Predict-both', 'w')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    pep = fields[2]
    if pep[-1] == 'K' or pep[-1] == 'R':
        if pep[0:-1].find('K') == -1 and pep[0:-1].find('R')== -1: 
            if pep in D:
                ouFile.write(pep + '\n')
inFile.close()
ouFile.close()
