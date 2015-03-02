inFile = open('deNGLY1_sig_proteincoding_down.txt')
D = {}
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    D[fields[-2]] =1
inFile.close()
inFile = open('de_NGLY1-KO_WT.sig.ortholog.proteincoding.human.down.txt')
head = inFile.readline()
for line in inFile:
    line =line.strip('\n')
    fields = line.split('\t')
    if fields[-1] in D:
        print(fields[-1])
inFile.close()
