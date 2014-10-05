D = {}
inFile = open('../../Genome/hg19_refGene.txt')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    ch = fields[2]
    start = int(fields[4])
    end = int(fields[5])
    gene = fields[12]
    D.setdefault(gene, [])
    D[gene].append([ch,start,end])
inFile.close()

inFile = open('NGLY1-unmapped.aligned.paired6.blated')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    ch = 'chr'+fields[1]
    start = int(fields[8])
    end = int(fields[9])
    for x in D['NGLY1']:
        if x[0] == ch:
            if x[1] <= start <= x[2] or x[1] <= end <= x[2]:
                print(line)
inFile.close()
