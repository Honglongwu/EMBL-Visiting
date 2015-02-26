import os
#ouFile = open('5-wrong-map-mouse-to-human', 'w')
ouFile = open('5-wrong-map-mouse-to-human2', 'w')
Fs = os.listdir('.')
for F in Fs: 
    Fname = F + '/align_summary.txt'
    if os.path.isfile(Fname):
        inFile = open(Fname)
        for line in inFile:
            line = line.strip()
            if line.find('Mapped') != -1:
                ouFile.write(F + '\t' + line + '\n')
                percent = float(line.split('(')[1].split('%')[0])
                if percent < 30:
                    print(F + '\t' + line)

        inFile.close()
ouFile.close()
