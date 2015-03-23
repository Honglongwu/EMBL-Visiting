D = {}
inFile = open('NGLY1-unmapped.aligned.paired4')
while True:
    line = inFile.readline().strip()
    if line:
        if line[0] == '>':
            head = '_'.join(line.split('\t'))
            D.setdefault(head, [])
        else:
            D[head].append(line)
    else:
        break
inFile.close()

inFile = open('NGLY1-unmapped.aligned.paired6.blated.filtered')
ouFile = open('NGLY1-unmapped.aligned.paired6.blated.filtered.num', 'w')
for line in inFile:
    fields = line.split('\t')
    for k in D:
        if fields[0] in k:
            fds = k[1:].split('_')
            n = fds[0]
            ouFile.write(n+'\t' + line)
            break
inFile.close()
ouFile.close()
