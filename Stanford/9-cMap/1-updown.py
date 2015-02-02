def cmap(inF):
    inFile = open(inF)
    ouFile1 = open(inF.split('.txt')[0] + '.up.txt', 'w')
    ouFile2 = open(inF.split('.txt')[0] + '.down.txt', 'w')

    head = inFile.readline()
    for line in inFile:
        line = line.strip()
        fields = line.split('\t')
        gene = fields[0]
        updown = float(fields[2])
        if updown > 0:
            ouFile1.write(gene + '\n')
        elif updown < 0: 
            ouFile2.write(gene + '\n')
        else:
            print(line)
    inFile.close()
    ouFile1.close()
    ouFile2.close()

cmap('de_CP1-B_MCP1-B.sig.txt')
cmap('de_CP3-B_Ctrl-B.sig.txt')
