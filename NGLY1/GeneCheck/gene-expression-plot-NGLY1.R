folder = '/g/steinmetz/hsun/NGLY1/NGLY1-wmueller'
load(file.path(folder,'counts-BCells.rda'))
load(file.path(folder,'gtf.rda'))
load(file.path(folder,'sampleAnnot-BCells.rda'))

library(DESeq2)
mat=assay(geneCounts)
dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~individual)
dds = DESeq(dds)
expr = counts(dds, normalized=T)
expr.raw = counts(dds, normalized=F)

pdf('BCells-NGLY1-Expression.pdf')
lattice::dotplot(expr[ids[ids$gene_name == 'NGLY1',]$gene_id,]~factor(sampleAnnot$individual,levels=c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), group=sampleAnnot$sampleStatus, auto.key=TRUE,pch=19, ylab="Normalized Gene Expression",main="NGLY1")
lattice::dotplot(expr.raw[ids[ids$gene_name == 'NGLY1',]$gene_id,]~factor(sampleAnnot$individual,levels=c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), group=sampleAnnot$sampleStatus, auto.key=TRUE,pch=19, ylab="Gene Expression (Raw Counts)",main="NGLY1")
dev.off()
