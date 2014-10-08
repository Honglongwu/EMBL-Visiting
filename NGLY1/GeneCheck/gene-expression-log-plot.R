folder = '/g/steinmetz/hsun/NGLY1/NGLY1-wmueller'
load(file.path(folder,'counts-BCells.rda'))
load(file.path(folder,'gtf.rda'))
load(file.path(folder,'sampleAnnot-BCells.rda'))

library(DESeq2)
mat=assay(geneCounts)
dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~individual)
sf = estimateSizeFactors(dds)
mat.sf = mat/sizeFactors(sf)

pdf('BCells-NPC1-DYNC1H1-Normalized-Expression.pdf')
lattice::dotplot(mat.sf[ids[ids$gene_name == 'NPC1',]$gene_id,]~factor(sampleAnnot$individual,levels=c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), group=sampleAnnot$sampleStatus, auto.key=TRUE,pch=19, ylab="Gene Expression",main="NPC1")
lattice::dotplot(mat.sf[ids[ids$gene_name == 'DYNC1H1',]$gene_id,]~factor(sampleAnnot$individual,levels=c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), group=sampleAnnot$sampleStatus, auto.key=TRUE,pch=19, ylab="Gene Expression",main="DYHC1H1")
dev.off()
