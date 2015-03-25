import os
def classification():
    ouFile1 = open('Yeast-peptide-Reverse','w')
    ouFile2 = open('Yeast-peptide-Annotated','w')
    ouFile3 = open('Yeast-peptide-sixFrame','w')
    Fs = os.listdir('.')
    for inF in Fs:
        if inF[-8:] == '.txt.fdr':
            inFile = open(inF)
            for line in inFile:
                line = line.strip()
                if line.find('REVERSE:') != -1:
                    ouFile1.write(line+'\n')
                elif line.find('pep:known') != -1:
                    ouFile2.write('ANNOTATED'+'\t'+line+'\n')
                elif line.find('SIX-FRAME')!=-1:
                    ouFile3.write('SIX-FRAME'+'\t'+line+'\n')
            inFile.close()
    ouFile1.close()
    ouFile2.close()
    ouFile3.close()

classification()
