import sys
D = {}
inFile = open('homologene.data')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    groupid = fields[0]
    D.setdefault(groupid, [])
    D[groupid].append(fields)
inFile.close()

D2 = {}
inFile = open('taxid_taxname')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    D2[fields[0]] = fields[1]
inFile.close()

for x in D:
    for y in D[x]:
        if y[3] == sys.argv[1] and y[1] == '9606':
            for m in D[x]:
                print(m[3]+'\t'+D2[m[1]])


