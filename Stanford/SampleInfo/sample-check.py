import os
inFile = open('NGLY1-Samples-To-Healx.txt')
head = inFile.readline()
S = 0
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    F = fields[1]
    s=float((os.stat(F).st_size))/1024/1024
    S += s

inFile.close()
print(S)
