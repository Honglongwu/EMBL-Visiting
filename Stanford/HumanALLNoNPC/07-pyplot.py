import matplotlib
matplotlib.use('Agg')

import pandas as pd
import pylab as pl

df = pd.read_table('NGLY1-PSM-Family.txt')
ouFile = open('Check-Pydata.txt','w')


AX = []
fig = pl.figure()
for i in range(0,6):

    ax = fig.add_axes([0.09, 0.05+0.15*i, 0.36, 0.15])
    ax.set_xlim(0,8)
    ax.set_xticks(range(0,8))
    ax.set_xticklabels([])
    #ax.set_yticklabels([])
    AX.append(ax)
    
    ax = fig.add_axes([0.45, 0.05+0.15*i, 0.27, 0.15])
    ax.set_xlim(0,6)
    ax.set_xticks(range(0,6))
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    AX.append(ax)
    
    ax = fig.add_axes([0.72, 0.05+0.15*i, 0.18, 0.15])
    ax.set_xlim(0,4)
    ax.set_xticks(range(0,4))
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    AX.append(ax)
    

AX[0].set_xticklabels(['','FCP1','MCP1','CP1','CP2','CP3','CP4','CP7',''])
AX[1].set_xticklabels(['','Ctrl','FCP1','MCP1','CP1','CP3',''])
AX[2].set_xticklabels(['','FCP1','MCP1','CP1',''])


for ax in AX:
    ax.axes.get_yaxis().set_visible(False)
    ax.axes.get_xaxis().set_visible(False)
for i in range(0,18,3):
    AX[i].yaxis.set_ticks_position('left')
    AX[i].axes.get_yaxis().set_visible(True)
for i in range(0,3):
    AX[i].xaxis.set_ticks_position('bottom')
    AX[i].axes.get_xaxis().set_visible(True)

for ax in AX[0:3]:
    for tick in ax.xaxis.get_major_ticks():
        tick.label.set_fontsize(9)

for i in range(0,18,3):
    for tick in AX[i].yaxis.get_major_ticks():
        tick.label.set_fontsize(8)
    AX[i].yaxis.set_ticks_position('left')


G = ['PSMD14','PSMD11','PSMD1','PSMC2','PSMB1','NGLY1']
for i,gene in enumerate(G):
    Expression = []
    xy = df[df['cellType']=='fibroblast'][['individual',gene]]
    val= xy.iloc[[10,11,12,13,0,1,2,3,4,5,6,7,8,9],1].tolist()
    color = ['b','b','b','b','r','r','r','r','r','r','r','r','r','r']
    AX[0+3*i].scatter([1,1,2,2,3,3,4,4,5,5,6,6,7,7],val,facecolor=color,edgecolor=color,linewidths=0 ,marker='o',s=20)
    Expression+=val
    
    xy = df[df['cellType']=='lymphoblast'][['individual',gene]]
    val = xy.iloc[[4,5,6,7,8,9,0,1,2,3],1].tolist()
    color = ['b','b','b','b','b','b','r','r','r','r']
    AX[1+3*i].scatter([1,1,2,2,3,3,4,4,5,5],val,facecolor=color,edgecolor=color,linewidths=0,marker='o',s=20)
    Expression+=val
    
    
    xy = df[df['cellType']=='iPS'][['individual',gene]]
    val = xy.iloc[[2,3,4,5,0,1],1].tolist()
    color = ['b','b','b','b','r','r']
    AX[2+3*i].scatter([1,1,2,2,3,3],val,facecolor=color,edgecolor=color,linewidths=0,marker='o',s=20)
    Expression+=val
    
    
    #AX[0+4*i].set_ylim(min(Expression)-100, max(Expression)+100)
    #AX[1+4*i].set_ylim(min(Expression)-100, max(Expression)+100)
    #AX[2+4*i].set_ylim(min(Expression)-100, max(Expression)+100)
    #AX[3+4*i].set_ylim(min(Expression)-100, max(Expression)+100)

    AX[0+3*i].set_ylim(0, max(Expression)+300)
    AX[1+3*i].set_ylim(0, max(Expression)+300)
    AX[2+3*i].set_ylim(0, max(Expression)+300)

    ouFile.write(gene + '\t' + '\t'.join([str(x) for x in Expression])+'\n')


for i,gene in enumerate(G):
    AX[2+3*i].text(4.15,AX[2+3*i].get_ylim()[1]/2.0, gene,verticalalignment='center')

AX[15].text(4,AX[15].get_ylim()[1]+100,'Fibroblast', horizontalalignment='center')
AX[16].text(3,AX[16].get_ylim()[1]+100,'Lymphoblast', horizontalalignment='center')
AX[17].text(2,AX[17].get_ylim()[1]+100,'iPS', horizontalalignment='center')



AX[0].set_yticks([500,1000])	
AX[3].set_yticks([500,1000,1500,2000])	
AX[6].set_yticks([1000,2000,3000,4000])	
AX[9].set_yticks([500,1000,1500])	
AX[12].set_yticks([500,1000,1500,2000])	
AX[15].set_yticks([500,1000])	
AX[9].text(-1.85,0,'Normalized gene expression', rotation='vertical',verticalalignment='center')

pl.savefig('NGLY1-PSM-Normalized-Human.pdf')
ouFile.close()


