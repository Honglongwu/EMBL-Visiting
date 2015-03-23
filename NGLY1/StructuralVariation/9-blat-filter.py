inFile = open('NGLY1-unmapped.aligned.paired6.blated.filtered.seq2.fa.blated')
D = {}
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    if float(fields[2]) > 90 and int(fields[3]) > 35:
        k = ':'.join(fields[0].split(':')[0:-1])
        D[k] = 1
inFile.close()

inFile = open('NGLY1-unmapped.aligned.paired6.blated.filtered.seq2.anno')
ouFile = open('NGLY1-unmapped.aligned.paired6.blated.filtered.seq2.anno.filtered', 'w')
while True:
    line1 = inFile.readline()
    line2 = inFile.readline()
    line3 = inFile.readline()
    line4 = inFile.readline()
    if line1:
        fields = line1.split('\t')
        if fields[0] not in D:
            ouFile.write(line1)
            ouFile.write(line2)
            ouFile.write(line3)
            ouFile.write(line4)
    else:
        break
inFile.close()
ouFile.close()
