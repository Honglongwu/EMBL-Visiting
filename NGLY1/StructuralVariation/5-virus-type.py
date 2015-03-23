inFile = open('NGLY1-Viruses-mapped2')
ouFile = open('NGLY1-Viruses-mapped2-virus-type', 'w')
D = {}
D2 = {}
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        fields = line1.split('\t')
        virus= fields[1]
        virus_pos = virus+':'+fields[8]+':'+fields[9]
        if virus_pos in D2:
            pass
        else:
            D.setdefault(virus, 0)
            D[virus] += 1
            D2[virus_pos] = 1
    else:
        break
inFile.close()

d = D.items()
d.sort(cmp=lambda x,y:cmp(float(x[1]),float(y[1])),reverse=True)
for x in d:
    ouFile.write(x[0] + '\t' + str(x[1]) + '\n')
ouFile.close()
