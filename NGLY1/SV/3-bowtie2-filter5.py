inFile = open('NGLY1-unmapped.aligned.paired3')
ouFile = open('NGLY1-unmapped.aligned.paired4')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        fields1 = line1.split('\t')
        fields2 = line2.split('\t')
        ch1 = fields1[2]
        pos1 = int(fields1[3])
        ch2 = fields2[2]
        pos2 = int(fields2[3])


    else:
        break
inFile.close()
ouFile.close()
