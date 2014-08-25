D = {}
inFile = open('ENSG00000151092')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    transcript_id = fields[-1].split(';')[1]
    exon_number = fields[-1].split(';')[2]

    if fields[2] == 'exon':
        D.setdefault(transcript_id, [])
        D[transcript_id].append([exon_number, int(fields[3]), int(fields[4])])
inFile.close()
def get_min_max(D):
    L = []
    for k in D:
        for x in D[k]:
            L.append(x[1])
            L.append(x[2])
    L.sort()
    return([L[0], L[-1], L[-1]-L[0]])

GL = []
for k in D:
    L = [0]*(get_min_max(D)[2])
    for exon in D[k]:
        for i in range(exon[1], exon[2]+1):
            print(i)
            L[i-get_min_max[0]] = 1
    GL.append(L) 

print(GL)


