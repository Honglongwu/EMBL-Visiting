import matplotlib
matplotlib.use('Agg')

import pandas as pd
import pylab as pl

df = pd.read_table('NGLY1-RADUBC-Family-Mouse.txt')


AX = []
fig = pl.figure()
for i in range(0,6):
    ax = fig.add_axes([0.2, 0.1+0.14*i, 0.6, 0.14])
    ax.set_xlim(0,3)
    ax.set_xticks(range(0,4))
    ax.set_xticklabels([])
    #ax.set_yticklabels([])
    AX.append(ax)
    
for ax in AX:
    ax.axes.get_yaxis().set_visible(False)
    ax.axes.get_xaxis().set_visible(False)
for i in range(0,6):
    AX[i].yaxis.set_ticks_position('left')
    AX[i].axes.get_yaxis().set_visible(True)

AX[0].set_xticklabels(['','WT','Ngly1-KO',''])
AX[0].xaxis.set_ticks_position('bottom')
AX[0].axes.get_xaxis().set_visible(True)


for i in range(0,6):
    AX[i].yaxis.set_ticks_position('left')


G = ['Uchl1', 'Ubc','Vcp','Rad23b','Rad23a','Ngly1']
for i,gene in enumerate(G):
    Expression = []
    xy = df[['sample',gene]]
    val= xy.iloc[[3,4,5,0,1,2],1].tolist()
    color = ['b','b','b','r','r','r']
    AX[i].scatter([1,1,1,2,2,2],val,facecolor=color,edgecolor=color,linewidths=0 ,marker='o',s=20)
    Expression=val
    AX[i].set_ylim(0, max(Expression)+500)

for i,gene in enumerate(G):
    AX[i].text(3.05,AX[i].get_ylim()[1]/2.0, gene,verticalalignment='center')

AX[0].set_yticks([1000,2000])	
AX[1].set_yticks([5000,10000])	
AX[2].set_yticks([5000,10000,15000])	
AX[3].set_yticks([5000,10000])	
AX[4].set_yticks([1000,2000])	
AX[5].set_yticks([500,1000])	
AX[2].text(-0.47,AX[2].get_ylim()[1]/2,'Normalized gene expression', rotation='vertical',verticalalignment='center')

pl.savefig('NGLY1-RADUBC-Normalized-Mouse.pdf')
