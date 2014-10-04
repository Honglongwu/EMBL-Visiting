import re
inFile = open('NGLY1-Structural-Variatioin-Candidates-cut5')
ouFile = open('NGLY1-Structural-Variatioin-Candidates-cut5-sample', 'w')
D = {}
while True:
    line1 = inFile.readline().strip()
    line2 = inFile.readline().strip()
    line3 = inFile.readline().strip()
    line4 = inFile.readline().strip()
    if line1:
        if len(line1.split('\t')) >12:
            k = line1.split('\t')[0]
            gene = line1.split('\t')[-1].split('|')[0]
            if gene == 'NAPA-AS1:NAPA':
                gene = 'NAPA'
            type1 = line1.split('\t')[-1].split('|')[1]
            type2 = line2.split('\t')[-1].split('|')[1]
            if type1 == 'EXON' or type2 == 'EXON':
                Type = 'EXON'
            elif type1 == 'UTR' or type2 == 'UTR':
                Type = 'UTR'
            else:
                Type = 'INTRON'
            #print(gene + '\t' + Type)
            D.setdefault(gene, [])
            fields = line3.split('\t')
            for fd in fields:
                x = fd.split('|')
                for y in x:
                    s = y.split(':')[0]
                    sr = re.search('_(.*?CP.*?)_',s)
                    if sr:
                        ss=sr.group(1)
                        if ss.find('ngly1_') !=-1:
                            if ss.find('FCP1') != -1:
                                ss = 'FCP1'
                            elif ss.find('MCP1') != -1:
                                ss = 'MCP1'
                            elif ss.find('CP1') != -1:
                                ss = 'CP1'
                            elif ss.find('CP2') != -1:
                                ss = 'CP2'
                            elif ss.find('CP3') != -1:
                                ss = 'CP3'
                            elif ss.find('CP4') != -1:
                                ss = 'CP4'
                        print(ss)
 
                                
 
 
 
 
                
    else:
        break

inFile.close()
ouFile.close()
