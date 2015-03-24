#!/usr/bin/env python
import sys

FDR = 0.01

inFile = open(sys.argv[1])
ouFile = open(sys.argv[1]+'.fdr', 'w')

D = {}
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    D[fields[0]] = line

def cmpfun(x,y):
    ex = float(x.split('\t')[4].split(':')[2])
    ey = float(y.split('\t')[4].split(':')[2])
    if ex < ey:
        return -1
    elif ex > ey:
        return 1
    else:
        return 0

d = D.items()
d.sort(cmp = lambda x,y:cmpfun(x[1],y[1]))

T = 0
F = 0
for item in d :
    if item[1].split('\t')[1].find('REVERSE') != -1:
        F += 1
    else:
        T += 1

    if float(2*F) / float(T + F) <= FDR:
        ouFile.write(item[1]+'\n')

inFile.close()
ouFile.close()


