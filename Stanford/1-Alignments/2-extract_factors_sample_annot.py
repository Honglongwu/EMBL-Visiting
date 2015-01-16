from operator import itemgetter
def format(F):
    inFile = open(F)
    ouFile = open(F.split('.txt')[0] + '.formated.txt', 'w')
    head = inFile.readline()

    L = []
    for line in inFile:
        line = line.strip()
        fields = line.split('\t')
        sampleName = fields[0]
        barcode = fields[1]
        filename = fields[2]
        laneName = fields[3]
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
        if passage != 'None':
            label = sample + '_' + biorep + '_' + passage
        else:
            label = sample + '_' + biorep
        L.append([sampleName, barcode, filename, laneName, name, sample, biorep, passage, lane, label])
            
        #print('\t'.join([sampleName, barcode, lane, name]))
    inFile.close()
    L.sort(key=itemgetter(5,7,6,8))
    
    ouFile.write('\t'.join(['SampleName', 'Barcode', 'Filename', 'LaneName', 'name', 'sample', 'biorep', 'passage', 'lane', 'label']) + '\n')

    for item in L:
        ouFile.write('\t'.join(item) + '\n')

    ouFile.close()



#format('sampleAnnot-2014-10-21.txt')
format('sampleAnnot-2014-11-10.txt')

