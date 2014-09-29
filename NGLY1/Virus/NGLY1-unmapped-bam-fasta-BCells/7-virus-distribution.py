inFile = open('NGLY1-Viruses-mapped2')
ouFile = open('NGLY1-Viruses-samples','w')
ouFile2 = open('NGLY1-Viruses-samples2','w')
D = {}
D2 = {}
V = 'NC_007605.1'
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        fields = line1.split('\t')
        if fields[1].split('|')[3] == V:
            sample = fields[-1]
            D.setdefault(sample,[])
            D[sample].append(fields[0])
            sample2 = fields[-1].split('_')[0]
            D2.setdefault(sample2,[])
            D2[sample2].append(fields[0])
    else:
        break
inFile.close()
for k in D:
    ouFile.write(k + '\t' + str(len(D[k])) + '\n')
ouFile.close()
for k in D2:
    ouFile2.write(k + '\t' + str(len(D2[k])) + '\n')
ouFile.close()
ouFile2.close()

