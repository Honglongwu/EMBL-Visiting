from operator import itemgetter
def format(F):
    inFile = open(F)
    head = inFile.readline()

    L = []
    for line in inFile:
        line = line.strip()
        fields = line.split('\t')
        sampleName = fields[0]
        barcode = fields[1]
        filename = fields[2]
        lane = fields[3]
        name = fields[4]
        if name.find('primary') != -1:
            fds = name.split('_')
            if fds[1][0:2] == 'WT':
                sample = fds[1][0:-1]
                biorep = 'biorep' + fds[1][-1]
                passage = fds[2]
                lane = fds[3]
            elif fds[2] != 'NO': 
                sample = fds[1] + '_' + fds[2][0:-1]
                biorep = 'biorep' + fds[2][-1]
                passage = fds[3]
                lane = fds[4]
            else:
                sample = fds[1] + '_' + 'KO'
                biorep = 'biorep1'
                passage = fds[3]
                lane = fds[4]
        else:
            fds = name.split('_')
            sample = fds[1]
            biorep = 'biorep' + fds[2]
            passage = 'None'
            lane = fds[3]

        #print('\t'.join([sample, biorep, passage, lane]))
        L.append([sample, biorep, passage, lane])
            
        #print('\t'.join([sampleName, barcode, lane, name]))
    inFile.close()
    L.sort(key=itemgetter(0,2,1,3))
    for item in L:
        print('\t'.join(item))



format('sampleAnnot-2014-10-21.txt')

