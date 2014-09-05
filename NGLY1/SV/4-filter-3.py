D = {}
inFile = open('NGLY1-unmapped.aligned.paired4')
while True:
    line = inFile.readline().strip()
    if line:
        if line[0] == '>':
            head = line
            D.setdefault(head,[])
        else:
            D[head].append(line)
    else:
        break
inFile.close()
 
D2 = {}
for k in D:
    D2.setdefault(k,[])
    for x in D[k]:
        fields = x.split('\t')
        fds = fields[0].split('|')
        if fds[-1] == '1':
            D2[k].append(fields[0][0:-2])
        elif fds[-1] == '2':
            pass
        else:
            x = fds[0]
            inFile = open('NGLY1-unmapped.fq')
            while True:
                line1 = inFile.readline()
                line2 = inFile.readline()
                line3 = inFile.readline()
                line4 = inFile.readline()
                line5 = inFile.readline()
                line6 = inFile.readline()
                line7 = inFile.readline()
                line8 = inFile.readline()
                if line1:
                    if x in line1:
                        D2[k].append(line1[1:-2])
                else:
                    break
            inFile.close()
for k in D2:
    print(k)
    print(D2[k])


