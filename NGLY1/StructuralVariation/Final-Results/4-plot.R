rt=read.table('NGLY1-Structural-Variatioin-Candidates-cut5-sample3',head=T)
rt.sub=rt[,3:dim(rt)[2]]
row.names(rt.sub)=rt[,1]

library("RColorBrewer")
library("gplots")

colors=c("white","magenta")
pdf('NGLY1-SV.pdf')
heatmap.2(as.matrix(rt.sub), col=colors, Rowv=F, Colv=F, scale="none", dendrogram="none", trace="none", cexRow=0.9,cexCol=0.9, key=F)
dev.off()

