inFile = open('UPF1-regulated.txt')
D = {}
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    fs =(fields[4]).strip().split(';')
    for x in fs:
        D[x] = 1
inFile.close()

inFile = open('DE_ngly1_twosets_genes.txt')
for line in inFile:
    line = line.strip()
    fields = line.split()
    if fields[1] in D:
        print(fields[1])
inFile.close()
