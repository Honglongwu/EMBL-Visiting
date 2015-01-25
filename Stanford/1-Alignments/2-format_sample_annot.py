from operator import itemgetter
def format(F):
    inFile = open(F)
    ouFile = open(F.split('.txt')[0] + '.formated.txt', 'w')

    if F.find('2014-10-21.txt')!=-1:
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
                    sample = fds[1] + '-' + fds[2][0:-1]
                    biorep = 'biorep' + fds[2][-1]
                    passage = fds[3]
                    lane = fds[4]
                else:
                    sample = fds[1] + '-' + 'KO'
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
        L.sort(key=itemgetter(5,7,6,8))
        
        ouFile.write('\t'.join(['SampleName', 'Barcode', 'Filename', 'LaneName', 'name', 'sample', 'biorep', 'passage', 'lane', 'label']) + '\n')
    
        for item in L:
            ouFile.write('\t'.join(item) + '\n')
            print(item[-1])

    #elif F == 'sampleAnnot-2014-11-10.txt':
    elif F.find('2014-11-10.txt')!=-1:
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
            fds = name.split('_')
            if name.find('primary') != -1:
                if fds[1][0:2] == 'Wt':
                    sample = 'WT'
                    biorep = 'biorep' + fds[1][-1]
                    passage = fds[2]
                    lane = fds[3]
                elif fds[1] == 'DoubleKO':
                    sample = 'Double-KO'
                    biorep = 'biorep' + fds[2]
                    passage = fds[3]
                    lane = fds[4]
                else:
                    sample = fds[1] + '-' + fds[2]
                    biorep = 'biorep' + fds[3]
                    passage = fds[4]
                    lane = fds[5]
            else:
                if fds[1][0:2] == 'Wt':
                    sample = 'WT'
                    biorep = 'biorep' + fds[1][-1]
                    passage = fds[2]
                    lane = fds[3]
                elif fds[1] == 'DoubleKO': 
                    sample = 'Double-KO'
                    biorep = 'biorep' + fds[2]
                    passage = fds[3]
                    lane = fds[4]
                elif fds[1] == 'NGLY1KO': 
                    sample = 'NGLY1-KO'
                    biorep = 'biorep' + fds[2]
                    passage = fds[3]
                    lane = fds[4]
                elif fds[1] == 'ENGaseKO': 
                    sample = 'ENGase-KO'
                    biorep = 'biorep' + fds[2]
                    passage = fds[3]
                    lane = fds[4]
    
            #print('\t'.join([sample, biorep, passage, lane]))
            if passage != 'None':
                label = sample + '_' + biorep + '_' + passage
            else:
                label = sample + '_' + biorep
            L.append([sampleName, barcode, filename, laneName, name, sample, biorep, passage, lane, label])
                
            #print('\t'.join([sampleName, barcode, lane, name]))
        L.sort(key=itemgetter(5,7,6,8))
        
        ouFile.write('\t'.join(['SampleName', 'Barcode', 'Filename', 'LaneName', 'name', 'sample', 'biorep', 'passage', 'lane', 'label']) + '\n')
    
        for item in L:
            ouFile.write('\t'.join(item) + '\n')
            print(item[-1])
    #elif F == 'sampleAnnot-2014-11-12.txt':
    elif F.find('2014-11-12.txt')!=-1:
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
            fds = name.split('_')
            sample = fds[1] + '-' + fds[2]
            biorep = 'biorep' + fds[3]
            passage = 'None'
            lane = fds[4]
            #print('\t'.join([sample, biorep, passage, lane]))
            if passage != 'None':
                label = sample + '_' + biorep + '_' + passage
            else:
                label = sample + '_' + biorep
            L.append([sampleName, barcode, filename, laneName, name, sample, biorep, passage, lane, label])
                
            #print('\t'.join([sampleName, barcode, lane, name]))
        L.sort(key=itemgetter(5,7,6,8))
        
        ouFile.write('\t'.join(['SampleName', 'Barcode', 'Filename', 'LaneName', 'name', 'sample', 'biorep', 'passage', 'lane', 'label']) + '\n')
    
        for item in L:
            ouFile.write('\t'.join(item) + '\n')
            print(item[-1])

        pass

    inFile.close()
    ouFile.close()



format('sampleAnnot-human-2014-10-21.txt')
format('sampleAnnot-mouse-2014-10-21.txt')
format('sampleAnnot-mouse-2014-11-10.txt')
format('sampleAnnot-human-2014-11-12.txt')

