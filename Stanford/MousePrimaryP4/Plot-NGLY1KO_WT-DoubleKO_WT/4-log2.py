D ={}
inFile = open('de_NGLY1-KO_WT.txt')
head = inFile.readline()
for line in inFile:
    fields = line.split('\t')
    D.setdefault(fields[0], [])
    print(fields[6])
    try:
        if float(fields[6]) < 0.05:
            D[fields[0]].append(fields[2])
        else:
            D[fields[0]].append('NA')
    except:
        pass
inFile.close()

inFile = open('de_Double-KO_WT_2014.10.21.txt')
head = inFile.readline()
for line in inFile:
    fields = line.split('\t')
    D.setdefault(fields[0], [])
    try:
        if float(fields[6]) < 0.05:
            D[fields[0]].append(fields[2])
        else:
            D[fields[0]].append('NA')
    except:
        pass
inFile.close()

ouFile = open('Foldchange-NGLY1_KOvsWT-Double_KOvsWT-sig','w')
ouFile.write('EnsemblID\tNGLY1_KOvsWT\tDouble_KOvsWT\n')
for k in D:
    if 'NA' not in D[k]:
        ouFile.write(k + '\t' + '\t'.join(D[k]) + '\n')
ouFile.close()


D = {}
inFile = open('de_NGLY1-KO_WT.txt')
head = inFile.readline()
for line in inFile:
    fields = line.split('\t')
    D.setdefault(fields[0], [])
    try:
        if float(fields[6]) < 0.05:
            D[fields[0]].append(fields[2])
        else:
            D[fields[0]].append('NA')
    except:
        pass
inFile.close()

inFile = open('de_NGLY1-KO_Double-KO_2014.10.21.txt')
head = inFile.readline()
for line in inFile:
    fields = line.split('\t')
    D.setdefault(fields[0], [])
    try:
        if float(fields[6]) < 0.05:
            D[fields[0]].append(fields[2])
        else:
            D[fields[0]].append('NA')
    except:
        pass
inFile.close()
ouFile = open('Foldchange-NGLY1_KOvsWT-NGLY1_KOvsDouble_KO-sig','w')
ouFile.write('EnsemblID\tNGLY1_KOvsWT\tNGLY1_KOvsDouble_KO\n')
for k in D:
    if 'NA' not in D[k]:
        ouFile.write(k + '\t' + '\t'.join(D[k]) + '\n')
ouFile.close()
