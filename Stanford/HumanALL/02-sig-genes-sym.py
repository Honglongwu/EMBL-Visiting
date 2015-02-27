inFile = open('deNGLY1_sig_proteincoding.txt')
ouFile = open('deNGLY1_sig_proteincoding_symbol.txt','w')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    ouFile.write(fields[-2] + '\n')
inFile.close()
ouFile.close()
