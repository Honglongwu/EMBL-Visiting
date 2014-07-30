folder='/g/steinmetz/hsun/NGLY1/NGLY1-wmueller/exon-CP4'
load(file.path(folder,'DE_NGLY1_DMSO-CP1MCP1FCP1.rda'))
cp1mcp1fcp1=dxr1
load(file.path(folder,'DE_NGLY1_DMSO-CP1CP4MCP1.rda'))
cp1cp4mcp1=dxr1
load(file.path(folder,'DE_NGLY1_DMSO-CP2CP3FCP1.rda'))
cp2cp3fcp1=dxr1
cp1mcp1fcp1siggene=unique(cp1mcp1fcp1$groupID[cp1mcp1fcp1$padj<0.01 & !is.na(cp1mcp1fcp1$padj)])
cp1cp4mcp1siggene=unique(cp1cp4mcp1$groupID[cp1cp4mcp1$padj<0.01 & !is.na(cp1cp4mcp1$padj)])
cp2cp3fcp1siggene=unique(cp2cp3fcp1$groupID[cp2cp3fcp1$padj<0.01 & !is.na(cp2cp3fcp1$padj)])
three_sets=intersect(intersect(cp1mcp1fcp1siggene,cp1cp4mcp1siggene),cp2cp3fcp1siggene)
two_sets=intersect(cp1cp4mcp1siggene,cp2cp3fcp1siggene)
load('/g/steinmetz/wmueller/NGLY1/gtf.rda')
genes = ids[ids$gene_name %in% three_sets,]
write.table(genes,'de_exon_ngly1_threesets_genes.txt',quote=F,row.names=F, col.names=F)
write.table(genes[1],'de_exon_ngly1_threesets_genes_id.txt',quote=F,row.names=F, col.names=F)
write.table(genes[2],'de_exon_ngly1_threesets_genes_symbol.txt',quote=F,row.names=F, col.names=F)

genes = ids[ids$gene_name %in% two_sets,]
write.table(genes,'de_exon_ngly1_twosets_genes.txt',quote=F,row.names=F, col.names=F)
write.table(genes[1],'de_exon_ngly1_twosets_genes_id.txt',quote=F,row.names=F, col.names=F)
write.table(genes[2],'de_exon_ngly1_twosets_genes_symbol.txt',quote=F,row.names=F, col.names=F)



#load(file.path(folder,'resNGLY1-ALL.rda'))
#samplesALL=res
#samplesALLsiggene=rownames(samplesALL[samplesALL$padj<0.01 & !is.na(samplesALL$padj),])
#four_sets=intersect(three_sets, samplesALLsiggene)
#length(four_sets)
