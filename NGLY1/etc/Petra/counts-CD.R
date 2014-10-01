library(DESeq2)

rt = read.table('Check-Gene-List')
colnames(rt) = c("Symbol","ID")

load('/g/steinmetz/hsun/NGLY1/NGLY1-wmueller/counts-BCells.rda')
data = assay(geneCounts)

CD=data[rownames(data) %in% rt$ID,]
write.table(CD,file='CDx-reads-count',quote=F,col.names=NA)
