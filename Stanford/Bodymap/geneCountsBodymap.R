load('Counts-Human-Bodymap.rda')
load('/g/steinmetz/hsun/Stanford/data/HumanGTF.rda')
library(DESeq2)
mat = assay(geneCounts)
gene.name = ids[match(rownames(mat),ids$gene_id),c('gene_name','gene_biotype')]
mat.name = cbind(gene.name,mat)
write.table(mat.name,file='geneCountsBodymap.txt',row.names=T,col.names=NA,sep='\t',quote=F)
