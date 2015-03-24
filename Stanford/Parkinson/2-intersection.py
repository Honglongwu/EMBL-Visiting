def intersection(inF1, inF2):
    D = {}
    inFile = open(inF1)
    for line in inFile:
        line = line.strip()
        D[line] = 1
    inFile.close()
    
    inFile = open(inF2)
    for line in inFile:
        line = line.strip()
        fields = line.split('\t')
        gene = fields[-2]
        print(gene)
        if gene in D:
            print(gene)
    inFile.close()

intersection('parkinson-down-filtered', 'deNGLY1_sig_proteincoding_down.txt')
intersection('parkinson-up-filtered', 'deNGLY1_sig_proteincoding_up.txt')
