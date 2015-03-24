def intersection(inF1, inF2):
    print('***')
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
        if gene in D:
            print(gene)
    inFile.close()

intersection('parkinson-down-filtered', 'deNGLY1_sig_proteincoding_down.txt')
intersection('parkinson-up-filtered', 'deNGLY1_sig_proteincoding_up.txt')
intersection('parkinson-down-filtered', 'deFibroblast_sig_proteincoding_down.txt')
intersection('parkinson-up-filtered', 'deFibroblast_sig_proteincoding_up.txt')


intersection('parkinson-down-filtered', 'deLymphoblast_sig_proteincoding_down.txt')
intersection('parkinson-up-filtered', 'deLymphoblast_sig_proteincoding_up.txt')

intersection('parkinson-down-filtered', 'deIPS_sig_proteincoding_down.txt')
intersection('parkinson-up-filtered', 'deIPS_sig_proteincoding_up.txt')


def intersection2(inF1, inF2):
    print('###')
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
        gene = fields[7].upper()
        if gene in D:
            print(gene)
    inFile.close()

intersection2('parkinson-down-filtered', 'de_NGLY1-KO_WT.sig.ortholog.proteincoding.human.down.txt')
intersection2('parkinson-up-filtered', 'de_NGLY1-KO_WT.sig.ortholog.proteincoding.human.up.txt')
