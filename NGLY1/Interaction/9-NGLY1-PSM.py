D = {}
ouFile = open('BIOGRID-ALL-Interaction-NGLY1-PSM', 'w')
inFile = open('BIOGRID-ALL-Interaction-NGLY1')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    D[fields[0]] =1
    D[fields[1]] =1
inFile.close()
D2 = {}
inFile = open('BIOGRID-ALL-Interaction')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    if fields[0][0:3] == 'PSM'  and fields[1] in D:
        D2.setdefault(fields[1], [])
        D2[fields[1]].append([fields[1],fields[0]])
    elif fields[1][0:3] == 'PSM'  and fields[0] in D:
        D2.setdefault(fields[0], [])
        D2[fields[0]].append([fields[0],fields[1]])
inFile.close()
for k in D2:
    for x in D2[k]:
        ouFile.write('\t'.join(x) + '\n')
ouFile.close()
