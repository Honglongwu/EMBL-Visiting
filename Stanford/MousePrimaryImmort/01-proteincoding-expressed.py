D = {}
inFile = open('/g/steinmetz/hsun/Stanford/data/Ensembl/Ortholog-Human-Mouse.txt')
for line in inFile:
    line = line.rstrip()
    fields = line.split('\t')
    mouse = fields[3]
    D.setdefault(mouse, [])
    D[mouse].append('\t'.join([fields[1], fields[0]]))
inFile.close()


def express(inF, ouF):
    inFile = open(inF)
    ouFile = open(ouF, 'w')
    head = inFile.readline()
    for line in inFile:
        line = line.strip()
        fields = line.split('\t')
        if fields[-1] == 'protein_coding':
            if float(fields[1]) > 20:
                if fields[0] in D:
                    ouFile.write(fields[0] + '\t' + fields[-2] + '\t' + '\t'.join(D[fields[0]])+ '\n')
                else:
                    ouFile.write(fields[0] + '\t' + fields[-2] + '\t\t' + '\n')
    inFile.close()
    ouFile.close()

express('de_NGLY1-KO_WT_2014.10.21.txt','NGLY1-KO_WT_2014.10.21_proteincoding-expressed-genes.txt')
express('de_NGLY1-KO_WT_2014.11.10.txt','NGLY1-KO_WT_2014.11.10_proteincoding-expressed-genes.txt')
express('de_NGLY1-KO_WT_immortP5.txt','NGLY1-KO_WT_immortP5_proteincoding-expressed-genes.txt')
