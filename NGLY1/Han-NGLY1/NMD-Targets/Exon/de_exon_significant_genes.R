folder = '/g/steinmetz/wmueller/NGLY1/exon-CP4/'
sig_gene=function(inFile)
{
load(file.path(folder,inFile))
gene=unique(dxr1$groupID[dxr1$padj<0.01 & !is.na(dxr1$padj)])
ouFile=paste0(strsplit(inFile,'[.]')[[1]][1],'.sig_gene.txt')
write.table(gene,ouFile,quote=F, col.names=F, row.names=F)
}
Files = c('DE_CP1.rda','DE_CP2.rda','DE_CP3.rda','DE_CP4.rda','DE_MCP1.rda','DE_FCP1.rda','DE_19.rda')
lapply(Files,sig_gene)
