inFile = open('NGLY1-SNV')
ouFile = open('NGLY1-SNV.sh', 'w')
I = 65
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    pos = fields[3] + ':' + str(int(fields[4])-I)
    bam = fields[0].split('flt.annovar.exonic_variant_function')[0] + 'bam'
    ouFile.write('samtools tview %s /g/steinmetz/hsun/NGLY1/Genome/Homo_sapiens.GRCh37.68.dna.chromosomes.withIVTs.fa -p %s\n'%(bam, pos))

inFile.close()
ouFile.close()
