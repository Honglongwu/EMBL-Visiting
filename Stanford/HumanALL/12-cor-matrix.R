library(DESeq2)
load('resNGLY1.rda')
load('/g/steinmetz/hsun/Stanford/data/HumanGTF.rda')
mat = assay(rld)

out = c('FirstGeneSymbol', 'SecondGeneSymbol', 'FirstGeneID', 'SecondGeneID', 'cor')
for (i in seq(1,dim(mat)[1]))
{
    gene = 'ENSG00000151092'
    x = mat[i,]
    y = mat[gene,]
    c = cor(x, y)
    out = rbind(out, c(ids[ids$gene_id==gene,'gene_name'], ids[ids$gene_id==rownames(mat)[i],'gene_name'], gene, rownames(mat)[i], c))
}
write.table(out, file = 'NGLY1-Genes-Correlation.txt', sep = '\t', quote=F, row.names=F, col.names=F)

