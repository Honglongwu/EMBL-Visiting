inFile = open('NGLY1-unmapped.aligned.paired6.blated.filtered.seq2')
ouFile = open('NGLY1-unmapped.aligned.paired6.blated.filtered.seq2.fa', 'w')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    line3 = inFile.readline().strip()
    line4 = inFile.readline().strip()
    if line1:
        seq = line4.split('\t')
        head = line1.split('\t')[0]
        for i,x in enumerate(seq):
            ouFile.write('>' + head +':'+ str(i)+'\n')
            ouFile.write(x + '\n')
    else:
        break
inFile.close()
ouFile.close()
