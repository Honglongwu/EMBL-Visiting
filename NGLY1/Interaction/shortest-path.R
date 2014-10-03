library(igraph)
rt = read.table("NGLY1-BioGrid",stringsAsFactors=F)
name = unique(c(rt[,1],rt[,2]))
g = graph.data.frame(rt,directed=F,vertices=data.frame(name=name))
