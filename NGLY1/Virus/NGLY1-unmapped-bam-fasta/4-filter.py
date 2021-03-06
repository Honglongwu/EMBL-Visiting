import os
Identity = 100
Length = 43
UN = {}
Fs = os.listdir('.')
ouFile = open('NGLY1-Viruses-mapped', 'w')
ouFile2 = open('NGLY1-Viruses-mapped2', 'w')
for F in Fs:
    if F[-6:] == 'blated':
        D = {}
        inFile = open(F[0:-7])
        while True:
            head = inFile.readline().strip()
            seq = inFile.readline().strip()
            if head:
                D[head[1:]] = seq
            else:
                break
        inFile.close()
        
        inFile = open(F)
        for line in inFile:
            line = line.strip()
            fields = line.split('\t')
            seqname = fields[0]
            seq = D[seqname]
            if float(fields[2]) >= Identity and float(fields[3]) >= Length:
                #ouFile.write('>' + line +'\t'+F[6:-13]+ '\n')
                #ouFile.write(seq + '\n')
                if fields[1][0:2] != 'gi':
                    UN[fields[0]] = 1
                elif fields[0] not in UN:
                    seqL = float(len(seq))
                    A = seq.count('A')/seqL
                    T = seq.count('T')/seqL
                    C = seq.count('C')/seqL
                    G = seq.count('G')/seqL
                    N = seq.count('N')/seqL
                    if A >0.9 or T >0.9 or C>0.9 or G>0.9 or N>0.9:
                        pass
                    else:
                        ouFile2.write('>' + line + '\t' + F[6:-13]+ '\n')
                        ouFile2.write(seq + '\n')
        inFile.close()
        os.remove(F)
ouFile.close()
ouFile2.close()

