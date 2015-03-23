D = {}
inFile = open('ENSG00000151092-GRCh37')
ouFile = open('ENSG00000151092-GRCh37-transcripts-unique-region', 'w')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    transcript_id = fields[-1].split(';')[1].strip()
    exon_number = fields[-1].split(';')[2].strip()

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

GL = {}
for k in D:
    L = [0]*(get_min_max(D)[2]+1)
    for exon in D[k]:
        for i in range(exon[1], exon[2]+1):
            L[i-get_min_max(D)[0]] = 1
    GL[k] = L

GLx = GL.items()
for i in range(len(GLx)):
    L = []
    for j in range(len(GLx[i][1])):
        if GLx[i][1][j] == 1:
            s = 0
            for m in range(len(GLx)):
                s += GLx[m][1][j]
            if s == 1:
                L.append(j+get_min_max(D)[0])
    if len(L)>0:
        ouFile.write(GLx[i][0]+'\n')
        ouFile.write('\t'.join([str(x) for x in L])+'\n')
ouFile.close()
