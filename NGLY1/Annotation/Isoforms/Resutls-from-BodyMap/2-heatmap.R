pdf('Transcripts-NGLY1-BodyMap.pdf')
library("RColorBrewer")
library("gplots")
hmcol = colorRampPalette(brewer.pal(9,"GnBu"))(100)
colors=c("white","red")
rt=read.table("NGLY1-BodyMap-Transcripts-formated", header=T, row.names=1, sep="\t")
rt.sub=rt[2:(dim(rt)[1]-1),]
heatmap.2(as.matrix(rt.sub), col=colors, Rowv=T, Colv=T, scale="none", dendrogram="none", trace="none", margin=c(20,10), cexRow=0.9,cexCol=0.9, key=F)
dev.off()
