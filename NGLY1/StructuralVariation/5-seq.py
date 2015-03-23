D = {}
inFile = open('NGLY1-unmapped.aligned.paired4')
while True:
    line = inFile.readline().strip()
    if line:
        if line[0] == '>':
            head = line[1:]
            D.setdefault(head,[])
        else:
            fields = line.split('\t')[0].split('|')
            D[head].append(fields[0])
    else:
        break
inFile.close()

inFile = open('NGLY1-unmapped.aligned.paired6.blated.filtered')
ouFile = open('NGLY1-unmapped.aligned.paired6.blated.filtered.seq', 'w')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        ouFile.write(line1 + '\n')
        ouFile.write(line2 + '\n')
        k = line1.split('\t')[0]
        k2 = '\t'.join(k.split('_'))
        v = '\t'.join(D[k2][0::2])
        if len(D[k2][0::2]) != int(line1.split('_')[0]):
            print('Warning:'+line1)
        ouFile.write(v + '\n')
        pass
    else:
        break
inFile.close()
ouFile.close()
