inFile = open('NGLY1-Viruses-mapped2')
ouFile = open('NGLY1-Viruses-mapped2-virus-type', 'w')
D = {}
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        fields = line1.split('\t')
        virus= fields[1]
        D.setdefault(virus, 0)
        D[virus] += 1
    else:
        break
inFile.close()

d = D.items()
d.sort(cmp=lambda x,y:cmp(float(x[1]),float(y[1])),reverse=True)
for x in d:
    ouFile.write(x[0] + '\t' + str(x[1]) + '\n')
ouFile.close()
