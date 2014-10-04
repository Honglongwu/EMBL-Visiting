D = {}
inFile = open('NGLY1-unmapped.fq')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    line3 = inFile.readline().strip()
    line4 = inFile.readline().strip()
    line5 = inFile.readline().strip()
    line6 = inFile.readline().strip()
    line7 = inFile.readline().strip()
    line8 = inFile.readline().strip()
    if line1:
        fields = line1.split('|')
        k=fields[0][1:]
        sample = '|'.join(fields[0:-2])[1:]
        seq = fields[-2]
        D[k] = [sample,seq]
    else:
        break
inFile.close()

inFile = open('NGLY1-unmapped.aligned.paired6.blated.filtered.seq')
ouFile = open('NGLY1-unmapped.aligned.paired6.blated.filtered.seq2','w')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    line3 = inFile.readline().strip()
    if line1:
        ouFile.write(line1+'\n')
        ouFile.write(line2+'\n')
        #ouFile.write(line3+'\n')
        fields = line3.split('\t')
        ouFile.write('\t'.join([D[x][0] for x in fields])+'\n')
        ouFile.write('\t'.join([D[x][1] for x in fields])+'\n')
    else:
        break
inFile.close()
ouFile.close()
