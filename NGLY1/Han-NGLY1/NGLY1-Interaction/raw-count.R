library(DESeq2)
load('counts-CP4.rda')
data=assay(geneCounts)

raw.count = function(gene)
{
x=data[rownames(data) == gene,]
write.table(x,paste0(gene,'.raw.txt'),col.names=F,row.names=F,quote=F)
}
raw.count('ENSG00000112096')

