library(igraph)
#rt = read.table("NGLY1-BioGrid",stringsAsFactors=F)
#rt = read.table("BIOGRID-ALL-Interaction",stringsAsFactors=F,sep='\t')
rt = read.table("BIOGRID-ALL-Interaction-No-UBC",stringsAsFactors=F,sep='\t')
name = unique(c(rt[,1],rt[,2]))
g = graph.data.frame(rt,directed=F,vertices=data.frame(name=name))

interaction = function(gene1, gene2)
{
    path = get.shortest.paths(g,gene1,gene2)$vpath[[1]]
    name[path]
}
interaction('NGLY1', 'VCP')
#interaction('NGLY1', 'UBC')
interaction('NGLY1', 'NPC1')
interaction('NGLY1', 'DYNC1H1')
interaction('NGLY1', 'TMF1')
interaction('NGLY1', 'PLXNB2')
interaction('NGLY1', 'PSMB1')
interaction('NGLY1', 'PSMC2')
interaction('NGLY1', 'PSMD1')
interaction('NGLY1', 'PSMD11')
interaction('NGLY1', 'PSMD14')
interaction('NGLY1', 'UCHL1')
interaction('UCHL1', 'PSMD1')
interaction('UCHL1', 'PSMD11')
interaction('UCHL1', 'PSMD14')
interaction('UCHL1', 'PSMB1')
interaction('UCHL1', 'PSMC2')
