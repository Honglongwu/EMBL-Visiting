D = {}
def mappingID(F):
    inFile = open(F)
    for line in inFile:
        line = line.strip()
        fields = line.split('\t')
        D[fields[4]] = fields[-1]
    inFile.close()

mappingID('/g/steinmetz/hsun/Stanford/1-Alignments/sampleAnnot-mouse-2014-10-21.formated.txt')
mappingID('/g/steinmetz/hsun/Stanford/1-Alignments/sampleAnnot-human-2014-10-21.formated.txt')
mappingID('/g/steinmetz/hsun/Stanford/1-Alignments/sampleAnnot-mouse-2014-11-10.formated.txt')
mappingID('/g/steinmetz/hsun/Stanford/1-Alignments/sampleAnnot-human-2014-11-12.formated.txt')

inFile = open('5-wrong-map-mouse-to-human2')
ouFile = open('5-wrong-map-mouse-to-human2.formated', 'w')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    sample = fields[0]
    info = fields[1]
    num = info.split('(')[0].split(':')[1].strip()
    percent = info.split('(')[1].split('%')[0].strip()
    ouFile.write(sample + '\t' +D[sample] + '\t' + num + '\t' + percent + '\n')

inFile.close()
ouFile.close()
