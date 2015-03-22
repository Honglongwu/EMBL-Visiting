inF = 'Saccharomyces_cerevisiae.R64-1-1.ncrna.fa.fa.pep'
inFile = open(inF)
ouFile1 = open(inF + '-2', 'w')
D = {}
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        peps = line2.split('*')
        for i,x in enumerate(peps):
            #if len(x) >= 95:
            if len(x) >= 6:
                D.setdefault(x, [])
                D[x].append(line1[1:] + ':' + str(i))
    else:
        for k in D:
            ouFile1.write('>' + '\t'.join(D[k])+'\n')
            ouFile1.write(k + '\n')
        break
inFile.close()
ouFile1.close()
