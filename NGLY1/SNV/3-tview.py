inFile = open('NGLY1-SNV')
ouFile = open('NGLY1-SNV.sh', 'w')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    pos = fields[3] + ':' + fields[4]
    bam = fields[0].split('flt.annovar.exonic_variant_function')[0] + 'bam'
    ouFile.write('samtools tview %s $hg19 -p %s\n'%(bam, pos))

inFile.close()
ouFile.close()
