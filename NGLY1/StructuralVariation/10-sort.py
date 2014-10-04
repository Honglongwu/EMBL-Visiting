inFile = open('NGLY1-unmapped.aligned.paired6.blated.filtered.seq2.anno.filtered')
ouFile = open('NGLY1-Structural-Variatioin-Candidates', 'w')
D = {}
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    line3 = inFile.readline().strip()
    line4 = inFile.readline().strip()
    k = line1.split('_')[0]
    print(k)
    D.setdefault(k, [])
    D[k].append([line1,line2,line3,line4])
inFile.close()
d = D.items()
d.sort(cmp=lambda x,y:cmp(x,y), reversed=True)
for x in d:
    ouFile.write('\n'.join(x[1]) + '\n')
ouFile.close()
