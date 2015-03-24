inF = 'Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.fa.pep'
inFile = open(inF)
ouFile1 = open(inF+'nonStop', 'w')
D1 = {}
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        peps = line2.split('*')
        for i,x in enumerate(peps):
            if len(x) >= 6:
                D1.setdefault(x, [])
                D1[x].append(line1 + ':' + str(i))
    else:
        for k in D1:
            ouFile1.write('\t'.join(D1[k]) + '\n')
            ouFile1.write(k + '\n')
        break
inFile.close()
ouFile1.close()
