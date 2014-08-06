library(DEXSeq)
folder='/g/steinmetz/wmueller/NGLY1/exon-CP4'
plotFolder = '/g/steinmetz/hsun/NGLY1/Han-NGLY1/NMD-Targets/Exon-exclusion/plot'
COUNT_MIN = 0
COUNT_MAX = 20
get_exon_count=function(inFile)
{
load(file.path(folder,inFile))
#ouFile = paste0(strsplit(inFile,'[.]')[[1]][1],'.exon.txt')
#cn=setdiff(colnames(dxr1),'genomicData')
#cn=c('groupID','featureID')
#exon=as.matrix(dxr1[dxr1$exonBaseMean==0,cn])
#exon=rownames(dxr1)[dxr1$exonBaseMean<=COUNT]
##rownames(dxr1[dxr1$padj<0.01 & !is.na(dxr1$padj),])
sig=dxr1[dxr1$padj<0.01 & !is.na(dxr1$padj),]
sig_count = sig$countData
sig_exclusion = sig[(sig_count[,1] <=COUNT_MIN & sig_count[,2] <= COUNT_MIN) & (sig_count[,3] >= COUNT_MAX & sig_count[,4] >= COUNT_MAX),]
sig_inclusion = sig[(sig_count[,3] <=COUNT_MIN  & sig_count[,4] <= COUNT_MIN ) & (sig_count[,1] >= COUNT_MAX & sig_count[,2] >=COUNT_MAX),]
sig_exclusion_gene = sig_exclusion$groupID
sig_inclusion_gene = sig_inclusion$groupID
for(gene in union(sig_exclusion_gene, sig_inclusion_gene))
{
filename = paste0(gene,'.',strsplit(inFile,'[.]')[[1]][1],'.pdf')
pdf(file.path(plotFolder, filename), width=12, height=8)
for(thisExon in gene){
        plotDEXSeq( dxr1, thisExon, legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 ,displayTranscripts=TRUE,
                           fitExpToVar="treatment",norCounts=TRUE, splicing=TRUE)
}
dev.off()
}
return(list(sig_exclusion_gene, sig_inclusion_gene))
}

#return(sig_exclusion_gene)
#write.table(exon,ouFile,quote=F,col.names=F,row.names=F)
get_element=function(x, i)
{
    return(x[i])
}

sample = c('DE_19.rda','DE_CP1.rda','DE_CP2.rda',
'DE_CP3.rda','DE_CP4.rda','DE_MCP1.rda','DE_FCP1.rda')
#exon_unique = unique(unlist(lapply(sample,get_exon_count)))
gene=lapply(sample,get_exon_count)
exclusion_gene = unique(unlist(lapply(gene, get_element,i=1)))
inclusion_gene = unique(unlist(lapply(gene, get_element,i=2)))
load('/g/steinmetz/wmueller/NGLY1/gtf.rda')
exclusion_gene_id = ids[ids$gene_name %in% exclusion_gene,c('gene_id','gene_name')]
inclusion_gene_id = ids[ids$gene_name %in% inclusion_gene,c('gene_id','gene_name')]

write.table(exclusion_gene_id,'de_exon_exclusion_gene.txt', row.names=F, col.names=F,quote=F)
write.table(inclusion_gene_id,'de_exon_inclusion_gene.txt',row.names=F, col.names=F,quote=F)


