folder = '/g/steinmetz/hsun/NGLY1/NGLY1-wmueller'
load(file.path(folder,'counts-BCells.rda'))
load(file.path(folder,'gtf.rda'))
load(file.path(folder,'sampleAnnot-BCells.rda'))

library(DESeq2)
mat=assay(geneCounts)
dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~individual)
dds = DESeq(dds)
#sf = estimateSizeFactors(dds)
#mat.sf = mat/sizeFactors(sf)
count.normalized = counts(dds, normalized=T)
count.raw = counts(dds, normalized=F)

pdf('BCells-Nerual-Gene-Expression.pdf')
lattice::dotplot(count.raw[ids[ids$gene_name == 'NPC1',]$gene_id,]~factor(sampleAnnot$individual,levels=c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), group=sampleAnnot$sampleStatus, auto.key=TRUE,pch=19, ylab="Gene Expression",main="NPC1")
lattice::dotplot(count.normalized[ids[ids$gene_name == 'NPC1',]$gene_id,]~factor(sampleAnnot$individual,levels=c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), group=sampleAnnot$sampleStatus, auto.key=TRUE,pch=19, ylab="Normalized Gene Expression",main="NPC1")

lattice::dotplot(count.raw[ids[ids$gene_name == 'DYNC1H1',]$gene_id,]~factor(sampleAnnot$individual,levels=c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), group=sampleAnnot$sampleStatus, auto.key=TRUE,pch=19, ylab="Gene Expression",main="DYHC1H1")
lattice::dotplot(count.normalized[ids[ids$gene_name == 'DYNC1H1',]$gene_id,]~factor(sampleAnnot$individual,levels=c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), group=sampleAnnot$sampleStatus, auto.key=TRUE,pch=19, ylab="Normalized Gene Expression",main="DYHC1H1")

lattice::dotplot(count.raw[ids[ids$gene_name == 'TRNP1',]$gene_id,]~factor(sampleAnnot$individual,levels=c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), group=sampleAnnot$sampleStatus, auto.key=TRUE,pch=19, ylab="Gene Expression",main="TRNP1")
lattice::dotplot(count.normalized[ids[ids$gene_name == 'TRNP1',]$gene_id,]~factor(sampleAnnot$individual,levels=c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), group=sampleAnnot$sampleStatus, auto.key=TRUE,pch=19, ylab="Normalized Gene Expression",main="TRNP1")

lattice::dotplot(count.raw[ids[ids$gene_name == 'PLXNB2',]$gene_id,]~factor(sampleAnnot$individual,levels=c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), group=sampleAnnot$sampleStatus, auto.key=TRUE,pch=19, ylab="Gene Expression",main="PLXNB2")
lattice::dotplot(count.normalized[ids[ids$gene_name == 'PLXNB2',]$gene_id,]~factor(sampleAnnot$individual,levels=c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), group=sampleAnnot$sampleStatus, auto.key=TRUE,pch=19, ylab="Normalized Gene Expression",main="PLXNB2")

dev.off()
