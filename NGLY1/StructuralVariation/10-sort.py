inFile = open('NGLY1-unmapped.aligned.paired6.blated.filtered.seq2.anno.filtered')
ouFile = open('NGLY1-Structural-Variatioin-Candidates', 'w')
ouFile2 = open('NGLY1-Structural-Variatioin-Candidates-num', 'w')
ouFile3 = open('NGLY1-Structural-Variatioin-Candidates-cut5', 'w')
ouFile4 = open('NGLY1-Structural-Variatioin-Candidates-cut5-gene', 'w')
ouFile5 = open('NGLY1-Structural-Variatioin-Candidates-cut5-gene2', 'w')
D = {}
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    line3 = inFile.readline().strip()
    line4 = inFile.readline().strip()
    if line1:
        k = int(line1.split('_')[0])
        D.setdefault(k, [])
        D[k].append([line1,line2,line3,line4])
    else:
        break

inFile.close()
d = D.items()
d.sort(cmp=lambda x,y:cmp(x,y), reverse=True)
for x in d:
    for y in x[1]:
        ouFile.write('\n'.join(y) + '\n')
    ouFile2.write(str(x[0]) + '\t' + str(len(x[1])) + '\n')
    if x[0] >= 5:
        for y in x[1]:
            ouFile3.write('\n'.join(y) + '\n')
            if len(y[0].split('\t')) >12 or len(y[1].split('\t'))>12:
                ouFile4.write(y[0].split('\t')[-1] + '\t' + y[1].split('\t')[-1] + '\n')
                ouFile5.write(y[0].split('\t')[-1].split('|')[0] + '\n')
ouFile.close()
ouFile2.close()
