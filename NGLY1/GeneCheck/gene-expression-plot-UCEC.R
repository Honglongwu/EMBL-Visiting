folder = '/g/steinmetz/hsun/NGLY1/TCGA-NGLY1'
load(file.path(folder,'UCEC.rda'))
load('/g/steinmetz/hsun/NGLY1/NGLY1-wmueller/gtf.rda')

library(DESeq2)
mat=ngly1.control
pdf('UCEC-NPC1-DYNC1H1-Expression.pdf')
lattice::dotplot(as.matrix(mat)[grepl('^NPC1\\|',rownames(mat)),]~ngly1.control.annotation$condition, group=ngly1.control.annotation$condition, auto.key=TRUE,pch=19, ylab="Gene Expression",main="NPC1")

lattice::dotplot(as.matrix(mat)[grepl('^DYCN1H1\\|',rownames(mat)),]~ngly1.control.annotation$condition, group=ngly1.control.annotation$condition, auto.key=TRUE,pch=19, ylab="Gene Expression",main="DYCN1H1")
dev.off()


pdf('UCEC-NPC1-DYNC1H1-Normalized-Expression.pdf')
sf = sizeFactors(dds)
mat = counts(dds)/sf
lattice::dotplot(as.matrix(mat)[grepl('^NPC1\\|',rownames(mat)),]~ngly1.control.annotation$condition, group=ngly1.control.annotation$condition, auto.key=TRUE,pch=19, ylab="Gene Expression",main="NPC1")

lattice::dotplot(as.matrix(mat)[grepl('^DYCN1H1\\|',rownames(mat)),]~ngly1.control.annotation$condition, group=ngly1.control.annotation$condition, auto.key=TRUE,pch=19, ylab="Gene Expression",main="DYCN1H1")
dev.off()
