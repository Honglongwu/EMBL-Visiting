D = {}
inFile = open('/g/steinmetz/hsun/NGLY1/Virus/viral.1.1.genomic.fna.fa')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        fields = line1.split('|')
        k = fields[3]
        D.setdefault(k, [])
        D[k].append(line1[1:])
    else:
        break
inFile.close()

inFile = open('NGLY1-Viruses-mapped2-virus-type')
ouFile = open('NGLY1-Viruses-mapped2-virus-type2', 'w')
inFile.close()
ouFile.close()
