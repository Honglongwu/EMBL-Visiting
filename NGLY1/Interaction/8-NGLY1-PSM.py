inFile = open('BIOGRID-ALL-Interaction')
D = {}
ouFile1 = open('BIOGRID-ALL-Interaction-PSM-1', 'w')
ouFile2 = open('BIOGRID-ALL-Interaction-PSM-2', 'w')
for line in  inFile:
    line = line.strip()
    fields = line.split('\t')
    if fields[0][0:3] == 'PSM'  and fields[1][0:3] == 'PSM':
        ouFile1.write(line + '\n')
        D.setdefault(fields[0], 0)
        D[fields[0]] += 1
        D.setdefault(fields[1], 0)
        D[fields[1]] += 1
inFile.close()
for k in D:
    ouFile2.write(k + '\t' + str(D[k]) + '\n')
