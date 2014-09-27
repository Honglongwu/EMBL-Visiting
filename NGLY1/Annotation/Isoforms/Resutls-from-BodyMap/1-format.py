D = {}
D.setdefault('Tissue', [])
D.setdefault('Expression', [])
D.setdefault('Others', [])

inFile = open('NGLY1-BodyMap-Transcripts.txt')
ouFile = open('NGLY1-BodyMap-Transcripts-formated', 'w')
line = inFile.readline().strip().split('\t')
D['Tissue'] = line
line = inFile.readline().strip().split('\t')
D['Expression'] = [int(x) for x in line]
line = inFile.readline().strip().split('\t')
D['Others'] = [int(x)-3 for x in line]

for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    for i,x in enumerate(fields):
        D.setdefault(x, [0]*len(D['Tissue']))
        D[x][i] = 1
inFile.close()
for k in D:
    ouFile.write(k + '\t' + '\t'.join([str(x) for x in D[k]]) + '\n')
ouFile.close()

