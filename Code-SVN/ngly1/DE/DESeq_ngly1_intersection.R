folder='/g/steinmetz/hsun/NGLY1/NGLY1-wmueller/DE_ngly1-CP4'
load(file.path(folder,'resCP1MCP1FCP1.rda'))
cp1mcp1fcp1=res
load(file.path(folder,'resCP1CP4MCP1.rda'))
cp1cp4mcp1=res
load(file.path(folder,'resCP2CP3FCP1.rda'))
cp2cp3fcp1=res
cp1mcp1fcp1siggene=rownames(cp1mcp1fcp1[cp1mcp1fcp1$padj<0.01 & !is.na(cp1mcp1fcp1$padj),])
cp1cp4mcp1siggene=rownames(cp1cp4mcp1[cp1cp4mcp1$padj<0.01 & !is.na(cp1cp4mcp1$padj),])
cp2cp3fcp1siggene=rownames(cp2cp3fcp1[cp2cp3fcp1$padj<0.01 & !is.na(cp2cp3fcp1$padj),])
three_sets=intersect(intersect(cp1mcp1fcp1siggene,cp1cp4mcp1siggene),cp2cp3fcp1siggene)
load('/g/steinmetz/wmueller/NGLY1/gtf.rda')
genes = ids[ids$gene_id %in% three_sets,]
write.table(genes,'DE_ngly1_threesets_genes.txt',quote=F,row.names=F, col.names=F)
write.table(genes[1],'DE_ngly1_threesets_genes_id.txt',quote=F,row.names=F, col.names=F)
write.table(genes[2],'DE_ngly1_threesets_genes_symbol.txt',quote=F,row.names=F, col.names=F)


