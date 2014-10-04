inFile = open('NGLY1-Structural-Variatioin-Candidates-cut5')
ouFile = open('NGLY1-Structural-Variatioin-Candidates-cut5-sample', 'w')
D = {}
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    line3 = inFile.readline().strip()
    line4 = inFile.readline().strip()
    if line1:
        if len(line1.split('\t')) >12:
            k = line1.split('\t')[0]
            gene = line1.split('\t')[-1].split('|')[0]
            if gene == 'NAPA-AS1:NAPA':
                gene = 'NAPA'
            type1 = line1.split('\t')[-1].split('|')[1]
            type2 = line2.split('\t')[-1].split('|')[1]
            if type1 == 'EXON' or type2 == 'EXON':
                Type = 'EXON'
            elif type1 == 'UTR' or type2 == 'UTR':
                Type = 'UTR'
            else:
                Type = 'INTRON'
            print(gene + '\t' + Type)
            D.setdefault(gene, [])
    else:
        break

inFile.close()
ouFile.close()
