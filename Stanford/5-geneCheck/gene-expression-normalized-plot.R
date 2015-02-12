folder = '/g/steinmetz/hsun/Stanford'
load(file.path(folder,'Counts-Mouse-2014-1011.rda'))
load(file.path(folder,'data/MouseGenome/MouseGTF.rda'))

library(DESeq2)
mat=assay(geneCounts)
dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~individual)
sf = estimateSizeFactors(dds)
mat.sf = mat/sizeFactors(sf)

pdf('BCells-NPC1-DYNC1H1-Normalized-Expression.pdf')
lattice::dotplot(mat.sf[ids[ids$gene_name == 'NPC1',]$gene_id,]~factor(sampleAnnot$individual,levels=c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), group=sampleAnnot$sampleStatus, auto.key=TRUE,pch=19, ylab="Gene Expression",main="NPC1")
lattice::dotplot(mat.sf[ids[ids$gene_name == 'DYNC1H1',]$gene_id,]~factor(sampleAnnot$individual,levels=c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), group=sampleAnnot$sampleStatus, auto.key=TRUE,pch=19, ylab="Gene Expression",main="DYHC1H1")
dev.off()
