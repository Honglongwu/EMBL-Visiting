inFile = open('NGLY1-unmapped.aligned.paired2')
ouFile = open('NGLY1-unmapped.aligned.paired3', 'w')
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    if line1:
        fields1 = line1.split('\t')
        fields2 = line2.split('\t')
        if fields1[2] == fields2[2] and -50<= int(fields1[3]) - int(fields2[3]) <= 50: 
            pass
        else:
            ouFile.write(line1 + '\n')
            ouFile.write(line2 + '\n')

    else:
        break
inFile.close()
ouFile.close()
