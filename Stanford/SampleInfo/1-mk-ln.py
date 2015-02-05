inFile = open('NGLY1-Samples-To-Healx.txt')
ouFile = open('NGLY1-Samples-To-Healx.sh', 'w')
head = inFile.readline()
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    fds = fields[1].split('/')
    name = fds[5]+'_' +fds[6] + '_' + fds[-1]
    ouFile.write('ln -s ' + fields[1] + ' ' + name + '\n')
inFile.close()
ouFile.close()
