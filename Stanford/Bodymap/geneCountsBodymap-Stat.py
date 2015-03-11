inFile = open('geneCountsBodymap.txt')
head = inFile.readline().strip('\n').split('\t')
D = {}
Tissue = []
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    for i in range(3, len(fields)):
        ts = head[i].split('.')[2]
        D.setdefault(ts, [])
        if int(fields[i]) > 30 and fields[2] == 'protein_coding' :
            D[ts].append(fields[1])
inFile.close()
d = D.items()
d.sort(cmp = lambda x,y :cmp(len(set(x[1])), len(set(y[1]))), reverse = True)
for item in d:
    print(item[0] + '\t' + str(len(set(item[1]))))
    Tissue.append(item[0])

def share(S1, S2):
    return len(S1 & S2)
print('' + '\t' + '\t'.join(Tissue))
for i in range(len(Tissue)):
    L = []
    for j in range(len(Tissue)):
        SN = share(set(D[Tissue[i]]), set(D[Tissue[j]]))
        L.append(str(SN))
    print(Tissue[i] + '\t' + '\t'.join(L))






