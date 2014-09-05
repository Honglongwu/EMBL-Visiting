D = {}
inFile = open('NGLY1-unmapped.aligned.paired4')
while True:
    line = inFile.readline().strip()
    if line:
        if line[0] == '>':
            line_next = inFile.readline().strip()
            fields = line_next.split('\t')
            fds = fields[0].split('|')
            k = '_'.join(line.split())
            if fds[-1] == '1' or fds[-1] == '2':
                seq = fds[-2]
                D[k] = seq
            else:
                D[k] = '@'+fds[0]
    else:
        break
inFile.close()

D2 = {}
inFile = open('NGLY1-unmapped.fq')
for line in inFile:
    if line[0]=='@':
        fields = line.split('|')
        D2[fields[0]]=fields[-2]
inFile.close()
ouFile = open('NGLY1-unmapped.aligned.paired5', 'w')
for k in D:
    if D[k][0]=='@':
        ouFile.write(k+'\n')
        ouFile.write(D2[D[k]]+'\n')
    else:
        ouFile.write(k+'\n')
        ouFile.write(D[k]+'\n')
ouFile.close()
