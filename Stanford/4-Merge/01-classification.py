def classification(inF):
    inFile = open(inF)
    ouFile0 = open(inF.split('.txt')[0] + '.proteincoding.txt','w')
    ouFile1 = open(inF.split('.txt')[0] + '.up.txt','w')
    ouFile2 = open(inF.split('.txt')[0] + '.down.txt','w')
    ouFile3 = open(inF.split('.txt')[0] + '.human.up.txt','w')
    ouFile4 = open(inF.split('.txt')[0] + '.human.down.txt','w')
    head = inFile.readline().strip('\n')
    for line in inFile:
        line = line.strip('\n')
        fields = line.split('\t')
        if fields[8] == 'protein_coding':
            ouFile0.write(line + '\n')
            if float(fields[2]) >= 0:
                ouFile1.write(line + '\n')
                if len(fields) > 9:
                    ouFile3.write(line + '\n')
            else:
                ouFile2.write(line + '\n')
                if len(fields) > 9:
                    ouFile4.write(line + '\n')
    inFile.close()
    ouFile0.close()
    ouFile1.close()
    ouFile2.close()
    ouFile3.close()
    ouFile4.close()

classification('de_NGLY1-KO_WT_2014.10.21.sig.ortholog.txt')

