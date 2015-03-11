inFile = open('geneCountsBodymap.txt')
head = inFile.readline('\n').strip('\t')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    for i in range(3, len(fields)):
        D.setdefault(head[i], [])
        if int(fields[i]) > 30:
            D[head[i]].append(fields[i])

inFile.close()
