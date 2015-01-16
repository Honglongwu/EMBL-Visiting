def format(F):
    inFile = open(F)
    head = inFile.readline()

    for line in inFile:
        line = line.strip()
        fields = line.split('\t')
        sampleName = fields[0]
        barcode = fields[1]
        filename = fields[2]
        lane = fields[3]
        name = fields[4]





        #print('\t'.join([sampleName, barcode, lane, name]))
        print(name)
    inFile.close()


format('sampleAnnot-2014-10-21.txt')

