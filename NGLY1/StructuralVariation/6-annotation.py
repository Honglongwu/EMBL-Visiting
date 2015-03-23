inFile = open('../Genome/hg19_refGene.txt')
D = {}
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    ch = fields[2]
    strand = fields[3]
    tx_start = int(fields[4]) + 1
    tx_end = int(fields[5])
    cds_start = int(fields[6]) + 1
    cds_end = int(fields[7])
    exon_start = [int(x)+1 for x in fields[9].split(',')[0:-1]]
    exon_end = [int(x) for x in fields[10].split(',')[0:-1]]
    gene = fields[12]
    if gene:
        D.setdefault(gene, [])
        D[gene].append([ch,strand,tx_start,tx_end,cds_start,cds_end,exon_start,exon_end])
inFile.close()
def anno(ch,start,end):
    gene = []
    utr = []
    exon = []
    for k in D:
        for v in D[k]:
            if ch == v[0] : 
                if  v[2]<= start <= v[3] or v[2] <= end <= v[3]:
                    gene.append(k)
                    if v[2]<= start <= v[4] or v[2]<= end <= v[4] or v[5] <= start <= v[3] or v[5] <= end <= v[3]:
                        utr.append(gene)
                    else:
                        for i in range(len(v[6])):
                            if v[6][i]<= start <= v[7][i] or v[6][i]<= end <= v[7][i]:
                                exon.append(i+1)
                        
    result = []
    if gene:
        result.append(':'.join(set(gene)))
        if utr:
            result.append('UTR')
        elif exon:
            result.append('EXON')
        else:
            result.append('INTRON')
    return(result)

inFile = open('NGLY1-unmapped.aligned.paired6.blated.filtered.seq2')
ouFile = open('NGLY1-unmapped.aligned.paired6.blated.filtered.seq2.anno', 'w')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    line3 = inFile.readline().strip()
    line4 = inFile.readline().strip()
    if line1:
        fields = line1.split('\t')
        ch = 'chr'+fields[1]
        start = int(fields[8])
        end = int(fields[9])
        an=anno(ch, start,end)
        ouFile.write(line1 +'\t'+ '|'.join(an) + '\n')
        fields = line2.split('\t')
        ch = 'chr'+fields[1]
        start = int(fields[8])
        end = int(fields[9])
        an=anno(ch, start,end)
        ouFile.write(line2 +'\t'+ '|'.join(an) + '\n')

        ouFile.write(line3 + '\n')
        ouFile.write(line4 + '\n')
    else:
        break
inFile.close()
ouFile.close()
