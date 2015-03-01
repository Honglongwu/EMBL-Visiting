import pandas as pd
import pylab as pl

df = pd.read_table('NGLY1-PSM-Family.txt')


AX = []
fig = pl.figure()
for i in range(0,6):

    ax = fig.add_axes([0.05, 0.05+0.15*i, 0.32, 0.15])
    ax.set_xticks(range(0,9))
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    AX.append(ax)
    
    ax = fig.add_axes([0.37, 0.05+0.15*i, 0.24, 0.15])
    ax.set_xticks(range(0,7))
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    AX.append(ax)
    
    ax = fig.add_axes([0.61, 0.05+0.15*i, 0.16, 0.15])
    ax.set_xticks(range(0,5))
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    AX.append(ax)
    
    ax = fig.add_axes([0.77, 0.05+0.15*i, 0.08, 0.15])
    ax.set_xticks(range(0,3))
    ax.set_xticklabels([])
    ax.set_yticklabels([])
    AX.append(ax)

AX[0].set_xticklabels(['','FCP1','MCP1','CP1','CP2','CP3','CP4','CP7',''])
AX[1].set_xticklabels(['','Ctrl','FCP1','MCP1','CP1','CP3',''])
AX[2].set_xticklabels(['','FCP1','MCP1','CP1',''])
AX[3].set_xticklabels(['','CP1',''])

gene = 'PSMD11'
Expression = []

xy = df[df['cellType']=='fibroblast'][['individual',gene]]
AX[0].scatter([1,1,2,2,3,3,4,4,5,5,6,6,7,7],xy[gene],c=['b','b','b','b','r','r','r','r','r','r','r','r','r','r'],linewidths=0,marker='o',s=50)
Expression+=xy[gene].tolist()

xy = df[df['cellType']=='lymphoblast'][['individual',gene]]
AX[1].scatter([1,1,2,2,3,3,4,4,5,5],xy[gene],c=['b','b','b','b','b','b','r','r','r','r'],linewidths=0,marker='o',s=50)
Expression+=xy[gene].tolist()

xy = df[df['cellType']=='iPS'][['individual',gene]]
AX[2].scatter([1,1,2,2,3,3],xy[gene],c=['b','b','b','b','r','r'],linewidths=0,marker='o',s=50)
Expression+=xy[gene].tolist()

xy = df[df['cellType']=='NPC'][['individual',gene]]
AX[3].scatter([1,1],xy[gene],c=['r','r'],linewidths=0,marker='o',s=50)
Expression+=xy[gene].tolist()

AX[0].set_ylim(min(Expression)-100, max(Expression)+100)
AX[1].set_ylim(min(Expression)-100, max(Expression)+100)
AX[2].set_ylim(min(Expression)-100, max(Expression)+100)
AX[3].set_ylim(min(Expression)-100, max(Expression)+100)


pl.show()


