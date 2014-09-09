import matplotlib
matplotlib.use('Agg')
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.path import Path
import matplotlib.patches as patches
import re



TranscriptColor = {}
inFile = open('ENSG00000151092-GRCh37')
for line in inFile:
    line = line.strip()
    fields = line.split('\t')
    if fields[2] == 'transcript':
        s=re.search('transcript_id "(\w+)"',fields[8])
        if s:
            TranscriptColor[s.group(1)] = fields[1]
inFile.close()

def get_color(transcript_id):
    if TranscriptColor[transcript_id] == 'protein_coding': 
        return 'red'
    elif TranscriptColor[transcript_id] == 'retained_intron': 
        return 'blue'
    elif TranscriptColor[transcript_id] == 'processed_transcript': 
        return 'magenta'
    elif TranscriptColor[transcript_id] == 'nonsense_mediated_decay': 
        return 'green'
    else:
        return 'yellow'


inFile = open('ENSG00000151092-GRCh37-transcripts-sorted')
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

MIN = min(Pos)
MAX = max(Pos)

fig = plt.figure()
ax = fig.add_axes([0.15,0.1,0.8,0.8])
ax.set_ylim(0,1)
ax.set_xlabel('15 isoforms of ENSG00000151092 (NGLY1)')
ax.set_xlim(MIN - 1000,MAX + 1000)
ax.set_xticklabels(['chr3:'+str(MIN),'chr3:'+str(MAX)], fontsize=8)
ax.set_xticks([MIN, MAX])
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

inFile = open('ENSG00000151092-GRCh37-transcripts-sorted')
n = 0
ytick = []
yticklabel = []
for line in inFile:
    n += 1
    line = line.strip()
    fields = line.split('\t')
    exon_start = [int(x) for x in fields[2:len(fields):3]]
    exon_end = [int(x) for x in fields[3:len(fields):3]]
    transcript_id = fields[0].split('"')[1]

    for i in range(len(exon_start)):
        exon = [(exon_start[i],0.05+0.06*(n-1)),(exon_start[i],0.08+0.06*(n-1)),(exon_end[i],0.08+0.06*(n-1)),(exon_end[i],0.05+0.06*(n-1)),(0,0)]
        path = Path(exon, codes)
        patch = patches.PathPatch(path, facecolor=get_color(transcript_id), edgecolor=get_color(transcript_id), lw=1)
        ax.add_patch(patch)

    for i in range(len(exon_end)-1):
        ax.plot([exon_start[i],exon_end[i+1]],[0.065+0.06*(n-1), 0.065+0.06*(n-1)],color='black')
    ytick.append(0.065+0.06*(n-1))
    yticklabel.append(transcript_id)
inFile.close()

ax.set_yticks(ytick)
ax.set_yticklabels(yticklabel, fontsize=8)

legend = []
legend.append(ax.plot([0,0],[0,0], color='red')[0])
legend.append(ax.plot([0,0],[0,0], color='blue')[0])
legend.append(ax.plot([0,0],[0,0], color='green')[0])
legend.append(ax.plot([0,0],[0,0], color='magenta')[0])

ax.legend(legend, ['protein_coding','retained_intron','nonsense_mediated_decay','processed_transcript'], loc='lower right', ncol=2, bbox_to_anchor=[1,1.01], prop={'size':8})

plt.savefig('NGLY1-Isoforms.pdf')
