library(DESeq2)
folder = '/g/steinmetz/hsun/Stanford'
load(file.path(folder,'Counts-Mouse-2014-1011.rda'))
load(file.path(folder,'data/MouseGenome/MouseGTF.rda'))

###### for sample annotation file 
######write.table(data.frame(colnames(geneCounts), colnames(geneCounts)),file=file.path(folder, "/5-geneCheck/MouseSampleAnnot.txt"),col.names=F, row.names=F,sep ="\t",quote=F)
##### need manual modify
sampleAnnot = read.table(file.path(folder,"/5-geneCheck/MouseSampleAnnot.txt"), head=T)
sampleAnnot$sample = relevel(sampleAnnot$sample,"WT_primaryP4_2014.11.10")


mat=assay(geneCounts)
dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sample)
sf = estimateSizeFactors(dds)
mat.sf = mat/sizeFactors(sf)

pdf(file.path(folder, '/5-geneCheck/Mouse-NGLY1-Normalized-Expression.pdf'))
gene = unname(unlist(mat.sf["ENSMUSG00000021785",]))
data = data.frame(sampleAnnot,gene)
lattice::dotplot(sample~gene|passage,data=data, auto.key=T, pch=19, ylab="Gene Expression",main="NGLY1", horizontal=FALSE) 
dev.off()
