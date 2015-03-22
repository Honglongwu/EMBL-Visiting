inF = 'Saccharomyces_cerevisiae.R64-1-1.ncrna.fa.fa.pep'
inFile = open(inF)
ouFile1 = open(inF+'-1', 'w')
ouFile2 = open(inF+'-2', 'w')
D1 = {}
D2 = {}
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        if line2.find('*') == -1:
            D1.setdefault(line2,[])
            D1[line2].append(line1)
        else:
            peps = line2.split('*')
            for i,x in enumerate(peps):
                if len(x) >= 6:
                    D2.setdefault(x, [])
                    D2[x].append(line1 + ':' + str(i))
    else:
        for k in D1:
            ouFile1.write('\t'.join(D1[k]) + '\n')
            ouFile1.write(k + '\n')
        for k in D2:
            ouFile2.write('\t'.join(D2[k])+'\n')
            ouFile2.write(k + '\n')
        break
inFile.close()
ouFile1.close()
ouFile2.close()
