def check_exist(pep, D):
    flag = 0
    for k in D:
        if pep in k:
            flag = 1
    return flag
def check_IL(pep, D):


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
        if flag:
            print(line)
        else:
            ouFile.write(line + '\n')
    inFile.close()
    ouFile.close()
filter('Yeast-peptide-sixFrame-pep')
