inFile = open('5-wrong-map-mouse-to-human2')
ouFile = open('5-wrong-map-mouse-to-human2.formated', 'w')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    sample = fields[0]
    info = fields[1]
    num = info.split('(')[0].split(':')[1].strip()
    percent = info.split('(')[1].split('%')[0].strip()
    ouFile.write(sample + '\t' + num + '\t' + percent + '\n')

inFile.close()
ouFile.close()
