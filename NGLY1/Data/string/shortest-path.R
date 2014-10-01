Score=700
library(igraph)
rt = read.table("9606.protein.links.v9.1.txt",stringsAsFactors=F,header=T)
rt = rt[rt[,3] >= Score,]
x = rt[,c(1,2)]
name = unique(c(x[,1],x[,2]))
g = graph.data.frame(x,directed=F,vertices=data.frame(name=name))
save(g,name,file="string.graph.rda")

NGLY1   ENSP00000280700
TRNP1   ENSP00000429216
TRNP1   ENSP00000436467
NPC1    ENSP00000269228
NPC1    ENSP00000408606
NPC1    ENSP00000444538

