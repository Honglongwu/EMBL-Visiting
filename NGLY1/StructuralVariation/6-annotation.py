inFile = open('../Genome/hg19_refGene.txt')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    tx_start = int(fields[])
    tx_end = int(fields[])
    cds_start = int(fields[])
    cds_end = int(fields[])
    exon_start = fields[].split(',')


inFile.close()
