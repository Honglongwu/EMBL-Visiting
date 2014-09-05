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
