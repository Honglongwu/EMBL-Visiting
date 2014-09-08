import matplotlib
matplotlib.use('Agg')
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.path import Path
import matplotlib.patches as patches

'''
inFile = open('POGK-A01-coverage')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    L1.append(int(fields[1]))
    L2.append(int(fields[2]))
inFile.close()

inFile = open('POGK-B01-coverage')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    L3.append(int(fields[1]))
    L4.append(int(fields[2]))
inFile.close()
'''

inFile = open('ENSG00000151092-trasncripts')
Pos = []
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    exon_start = [int(x) for x in fields[2:len(fields):3]]
    exon_end = [int(x) for x in fields[3:len(fields):3]]
    for x in exon_start:
        Pos.append(x)
    for x in exon_end:
        Pos.append(x)

MIN = min(Pos) - 1000
MAX = max(Pos) + 1000

fig = plt.figure()
'''
ax = fig.add_axes([0.1,0.6,0.8,0.38])
ax.set_xlim(MIN,MAX)
#ax.set_ylim(min(L2),int(max(L2)*1.1))
ax.set_xticklabels([])
ax.set_ylabel('A01')
#ax.plot(L1, L2,'r.')

ax = fig.add_axes([0.1,0.2,0.8,0.38])
ax.set_xlim(MIN,MAX)
#ax.set_ylim(min(L4),int(max(L4)*1.1))
ax.set_xticklabels([])
ax.set_ylabel('B01')
#ax.plot(L3, L4, 'b.')
'''

ax = fig.add_axes([0.1,0.1,0.8,0.8])
ax.set_ylim(0,1)
ax.set_xlim(MIN,MAX)
ax.set_ylabel('NGLY1 Isoforms')
ax.set_xticklabels([])
ax.set_xticks([])
ax.set_yticklabels([])
ax.set_yticks([])
#ax.axes.get_yaxis().set_visible(False)
#ax.axes.get_xaxis().set_visible(False)

codes = [Path.MOVETO,
         Path.LINETO,
         Path.LINETO,
         Path.LINETO,
         Path.CLOSEPOLY,
         ]   
#exon1

inFile = open('ENSG00000151092-trasncripts')
n = 0
for line in inFile:
    n += 1
    line = line.strip()
    fields = line.split('\t')
    exon_start = [int(x) for x in fields[2:len(fields):3]]
    exon_end = [int(x) for x in fields[3:len(fields):3]]

    for i in range(len(exon_start)):
        exon = [(exon_start[i],0.05+0.06*(n-1)),(exon_start[i],0.08+0.06*(n-1)),(exon_end[i],0.08+0.06*(n-1)),(exon_end[i],0.05+0.06*(n-1)),(0,0)]
        path = Path(exon, codes)
        patch = patches.PathPatch(path, facecolor='red', edgecolor='red', lw=1)
        ax.add_patch(patch)

    for i in range(len(exon_end)-1):
        ax.plot([exon_start[i],exon_end[i+1]],[0.065+0.06*(n-1), 0.065+0.06*(n-1)],color='green')

     
inFile.close()


#cds = [25760950,25824881]
#ax.plot([cds[0],cds[0]],[0.3,0.7],'m-',linewidth=2)
#ax.plot([cds[1],cds[1]],[0.3,0.7],'m-',linewidth=2)





#ax.text((105+581)/2.0,-0.25,'E6',horizontalalignment='center',verticalalignment='center',fontsize=6)

plt.savefig('POGK-Expression-noMax.pdf')
