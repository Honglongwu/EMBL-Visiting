def check_exist(pep, D):
    flag = 0
    for k in D:
        if pep in k:
            flag = 1
    return flag
def check_IL(pep, D):
    L = []
    for i in range(len(pep)):
        if pep[i] == 'I' or pep[i] == 'L':
            L.append(i)
    
    S = set()
    S.add(pep)
    for i in range(len(L)):
        S2 = set()
        for pep in S:
            n = L[i]
            pep1 = pep[0:n] + 'I' + pep[n+1:]
            pep2 = pep[0:n] + 'L' + pep[n+1:]
            S2.add(pep1)
            S2.add(pep2)
        S = S2
    res = []
    for p in S:
        for k in D:
            if p in D:
                res.append(p)
                break
    return res

def filter(inF):
    D = {}
    inFile = open('/g/steinmetz/hsun/TIFproteome/Annotation/Ensembl/Saccharomyces_cerevisiae.R64-1-1.pep.all.fa.fa')
    while True:
        line1 = inFile.readline().strip()
        line2 = inFile.readline().strip()
        if line1:
            D.setdefault(line2, [])
            D[line2].append(line1)
        else:
            break
    inFile.close()
    inFile = open(inF)
    ouFile = open(inF + '-filtered', 'w')
    for line in inFile:
        line = line.strip()
        fields = line.split('\t')
        pep = fields[0]
        flag = check_exist(pep, D)
        res = check_IL(pep, D)
        if flag:
            print(line)
            pass
        elif res:
            print(res)
        else:
            ouFile.write(line + '\n')
    inFile.close()
    ouFile.close()
filter('Yeast-peptide-sixFrame-pep')
