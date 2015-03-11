inFile = open('geneCountsBodymap.txt')
ouFile1 = open('geneCountsBodymap-tissue-number.txt', 'w')
ouFile2 = open('geneCountsBodymap-tissue-cmp.txt', 'w')
head = inFile.readline().strip('\n').split('\t')
D = {}
Tissue = []
Total = []
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    for i in range(3, len(fields)):
        ts = head[i].split('.')[2]
        D.setdefault(ts, [])
        if fields[2] == 'protein_coding' :
            Total.append(fields[1])
            if int(fields[i]) > 30:
                D[ts].append(fields[1])
inFile.close()
d = D.items()
d.sort(cmp = lambda x,y :cmp(len(set(x[1])), len(set(y[1]))), reverse = True)
ouFile1.write('tissue\tgene_expressed_number\t' + 'gene_expressed_percentage\n')
for item in d:
    ouFile1.write(item[0] + '\t' + str(len(set(item[1]))) +'\t'+'%.0f'%(float(len(set(item[1])))/len(set(Total))*100)+'%'+ '\n')
    Tissue.append(item[0])
ouFile1.write('Total\t' + str(len(set(Total))) +'\t'+'100%'+ '\n')

def share(S1, S2):
    N = len(S1 & S2)
    P = '%.0f'%(float(N)/len(S1)*100)
    return(str(N) + ' (' + P + '%)')
ouFile2.write('' + '\t' + '\t'.join(Tissue) + '\n')
for i in range(len(Tissue)):
    L = []
    for j in range(len(Tissue)):
        SN = share(set(D[Tissue[i]]), set(D[Tissue[j]]))
        L.append(str(SN))
    ouFile2.write(Tissue[i] + '\t' + '\t'.join(L) + '\n')
ouFile1.close()
ouFile2.close()






