import os
import stat
inFile = open('NGLY1-Samples-To-Healx')
ouFile = open('NGLY1-Samples-To-Healx.sh', 'w')
ouFile3 = open('NGLY1-Samples-To-Healx-need-permission.sh', 'w')
ouFile2 = open('NGLY1-Samples-To-Healx.txt', 'w')
head = inFile.readline().strip()
ouFile2.write(head + '\n')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    fds = fields[1].split('/')
    #name = fds[5]+'_' +fds[6] + '_' + fds[-1]
    name = fds[-1]
    ouFile2.write('\t'.join([fields[0],name,fields[2],fields[3]])+'\n')
    mask = int(oct(os.stat(fields[1]).st_mode)[-1])
    if mask == 0 :
        ouFile.write('#ln -s ' + fields[1] + ' ' + name + '\n')
        ouFile3.write(fields[1] + '\n')
    else:
        ouFile.write('ln -s ' + fields[1] + ' ' + name + '\n')


inFile.close()
ouFile.close()
ouFile2.close()
ouFile3.close()
