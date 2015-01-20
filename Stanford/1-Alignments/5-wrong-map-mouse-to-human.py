import os
ouFile = open('5-wrong-map-mouse-to-human', 'w')
Fs = os.listdir('.')
for F in Fs: 
    Fname = F + '/align_summary.txt'
    if os.path.isfile(Fname):
        inFile = open(Fname)
        for line in inFile:
            line = line.strip()
            if line.find('Mapped') != -1:
                ouFile.write(F + '\t' + line + '\n')
        inFile.close()
ouFile.close()
