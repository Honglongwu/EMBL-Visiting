inFile = open('factorbookMotifPos.txt')
TF = []
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    TF.append(fields)
inFile.close()

inFile = open('Genes-Interested-Pos')
ouFile = open('Genes-Interested-TF', 'w')

for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    gene = fields[0]
    ch = fields[1]
    strand = fields[2]
    start = int(fields[3])
    end = int(fields[4])
    for x in TF:
        if ch == x[1] and strand == x[6]:
            if start<= int(x[2]) <= end or start<= int(x[3]) <= end:
                ouFile.write(line + '\t' + '\t'.join(x[1:])+'\n')
inFile.close()
ouFile.close()
