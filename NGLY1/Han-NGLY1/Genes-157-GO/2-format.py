import re
inFile = open('GOFUNCTION.txt')
ouFile = open('NGLY1-sig-GOFUNCTION.txt', 'w')
header = inFile.readline()
D = {}
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    k = fields[1] + ' (' + fields[0] + ',padj=' + fields[3] + ',' + 'N=' + fields[8] + ')'
    s=re.findall('(\w+)  -  ', fields[9])
    if s:
        D[k] = s
inFile.close()

d = D.items()
d.sort(lambda x,y:cmp(len(x[1]), len(y[1])), reverse=True)
for x in d:
    if len(x[1]) > 10:
        ouFile.write(x[0] + '\t' + '\t'.join(x[1]) + '\n')
ouFile.close()
