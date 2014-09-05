inFile = open('NGLY1-unmapped.aligned.paired6.fa.blated')
ouFile = open('NGLY1-unmapped.aligned.paired6.fa.blated.filtered', 'w')
D = {}
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    k = fields[0]
    D.setdefault(k,[])
    D[k].append(line)
inFile.close()

for k in D:
    if len(D[k]) == 2:
        fields1 = D[k][0].split('\t')
        fields2 = D[k][1].split('\t')
        pos1 = int(fields1[6])
        pos2 = int(fields1[7])
        pos3 = int(fields2[6])
        pos4 = int(fields2[7])
        if pos1 + pos2 < pos3 + pos4:
            if -5<pos3 - pos2 <5 and pos1 <5 and pos4 >40 and pos2-pos1>15 and pos4-pos3>15:
                ouFile.write(D[k][0]+'\n')
                ouFile.write(D[k][1]+'\n')
        else:

            if -5 < pos1 - pos4 <5 and pos3 <5 and pos2 >40 and pos2-pos1>15 and pos4-pos3>15:
                ouFile.write(D[k][0]+'\n')
                ouFile.write(D[k][1]+'\n')
        
