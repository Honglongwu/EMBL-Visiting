def classification(inF):
    inFile = open(inF)
    ouFile0 = open(inF.split('.txt')[0] + '.proteincoding.txt','w')
    ouFile1 = open(inF.split('.txt')[0] + '.proteincoding.up.txt','w')
    ouFile2 = open(inF.split('.txt')[0] + '.proteincoding.down.txt','w')
    ouFile3 = open(inF.split('.txt')[0] + '.proteincoding.human.up.txt','w')
    ouFile4 = open(inF.split('.txt')[0] + '.proteincoding.human.down.txt','w')
    head = inFile.readline()
    ouFile0.write(head)
    ouFile1.write(head)
    ouFile2.write(head)
    ouFile3.write(head)
    ouFile4.write(head)
    for line in inFile:
        line = line.rstrip()
        fields = line.split('\t')
        if float(fields[1]) > 20: 
            if fields[8] == 'protein_coding':
                ouFile0.write(line + '\n')
                if float(fields[2]) >= 0:
                    ouFile1.write(line + '\n')
                    if len(fields)>9:
                        ouFile3.write(line + '\n')
                else:
                    ouFile2.write(line + '\n')
                    if len(fields)>9:
                        ouFile4.write(line + '\n')
    inFile.close()
    ouFile0.close()
    ouFile1.close()
    ouFile2.close()
    ouFile3.close()
    ouFile4.close()

classification('de_NGLY1-KO_WT.sig.ortholog.txt')

