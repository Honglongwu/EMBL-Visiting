import os
DIR = '.'
files = os.listdir(DIR)
L = []
for f in files:
    if f.find('.blat.sh')!=-1:
        L.append(f)

N = 5
for i in range(0,len(L),N):
    f = i/N
    ouFile= open(DIR+'/'+'qsub.'+str(f)+'.sh','w')
    ouFile.write('cd /g/steinmetz/hsun/NGLY1/SV'+'\n')
    for j in range(N):
        if i+j < len(L):
            ouFile.write('sh '+L[i+j]+'\n')
    ouFile.close()
