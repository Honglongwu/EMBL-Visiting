import matplotlib
matplotlib.use('Agg')
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.path import Path
import matplotlib.patches as patches

L1 = []
L2 = []
L3 = []
L4 = []

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


MIN = 25760434
MAX = 25824989
fig = plt.figure()
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

ax = fig.add_axes([0.1,0.02,0.8,0.16])
ax.set_ylim(0,1)
ax.set_xlim(MIN,MAX)
ax.set_ylabel('POGK')
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
exon_start = '25760434,25761504,25770623,25773809,25775362,25777494,25778824,25781067,25792588,25805556,25820064,25824750,'.split(',')
exon_end = '25761126,25761682,25770809,25773974,25775473,25777640,25778946,25781290,25792754,25805802,25820179,25824989,'.split(',')
for i in range(len(exon_start)-1):
    exon = [(exon_start[i],0.1),(exon_start[i],0.2),(exon_end[i],0.2),(exon_end[i],0.1),(0,0)]
    path = Path(exon, codes)
    patch = patches.PathPatch(path, facecolor='green', lw=1)
    ax.add_patch(patch)
#exon2
exon_start = '25760434,25761504,25770623,25773809,25775362,25777494,25778824,25781067,25792588,25805556,25820064,25831351,'.split(',')
exon_end = '25761126,25761682,25770809,25773974,25775473,25777640,25778946,25781290,25792754,25805802,25820179,25831530,'.split(',')
for i in range(len(exon_start)-1):
    exon = [(exon_start[i],0.3),(exon_start[i],0.4),(exon_end[i],0.4),(exon_end[i],0.3),(0,0)]
    path = Path(exon, codes)
    patch = patches.PathPatch(path, facecolor='green', lw=1)
    ax.add_patch(patch)



#cds = [25760950,25824881]
#ax.plot([cds[0],cds[0]],[0.3,0.7],'m-',linewidth=2)
#ax.plot([cds[1],cds[1]],[0.3,0.7],'m-',linewidth=2)





#ax.text((105+581)/2.0,-0.25,'E6',horizontalalignment='center',verticalalignment='center',fontsize=6)

plt.savefig('POGK-Expression-noMax.pdf')
