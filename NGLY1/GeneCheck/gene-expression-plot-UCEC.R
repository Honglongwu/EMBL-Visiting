folder = '/g/steinmetz/hsun/NGLY1/TCGA-NGLY1'
load(file.path(folder,'UCEC.rda'))
load(file.path(folder,'gtf.rda'))

library(DESeq2)
mat=assay(geneCounts)
pdf('UCEC-NPC1-DYNC1H1-Expression.pdf')
lattice::dotplot(mat[ids[ids$gene_name == 'NPC1',]$gene_id,]~factor(sampleAnnot$individual), group=sampleAnnot$sampleStatus, auto.key=TRUE,pch=19, ylab="Gene Expression",main="NPC1")
lattice::dotplot(mat[ids[ids$gene_name == 'DYNC1H1',]$gene_id,]~factor(sampleAnnot$individual), group=sampleAnnot$sampleStatus, auto.key=TRUE,pch=19, ylab="Gene Expression",main="DYHC1H1")
dev.off()
