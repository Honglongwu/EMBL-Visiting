D1 = {}
inFile = open('Check-Pydata.txt')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    D1.setdefault(fields[0], [])
    for x in fields[1:]:
        D1[fields[0]].append(int(float(x)))
inFile.close()

D2 = {}
inFile = open('Check-Rdata.txt')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    D2.setdefault(fields[0], [])
    for x in fields[1:]:
        D2[fields[0]].append(int(float(x)))
inFile.close()

for k in D1:
    for i,x in enumerate(D1[k]):
        print(x==D2[k][i])

