library(DEXSeq)
folder='/g/steinmetz/wmueller/NGLY1/drug-effect-pairwise-ExonLevel'
plotFolder = '/g/steinmetz/hsun/NGLY1/Han-NGLY1/NMD-Targets/Exon-exclusion/plot'
COUNT_MIN = 0
COUNT_MAX = 20
get_exon_count=function(inFile)
{
load(file.path(folder,inFile))
sig=dxr1[dxr1$padj<0.01 & !is.na(dxr1$padj),]
sig_count = sig$countData
sig_exclusion = sig[(sig_count[,1] <=COUNT_MIN & sig_count[,2] <= COUNT_MIN) & (sig_count[,3] >= COUNT_MAX & sig_count[,4] >= COUNT_MAX),]
sig_inclusion = sig[(sig_count[,3] <=COUNT_MIN  & sig_count[,4] <= COUNT_MIN ) & (sig_count[,1] >= COUNT_MAX & sig_count[,2] >=COUNT_MAX),]
sig_exclusion_gene = sig_exclusion$groupID
sig_inclusion_gene = sig_inclusion$groupID
sig_exclusion_exon = sig_exclusion
sig_inclusion_exon = sig_inclusion
return(list(sig_exclusion_exon, sig_inclusion_exon))
}

get_element=function(x, i)
{
    return(x[i])
}

sample = c('de_19.rda','de_CP1.rda','de_CP2.rda',
'de_CP3.rda','de_CP4.rda','de_MCP1.rda','de_FCP1.rda')
#exon_unique = unique(unlist(lapply(sample,get_exon_count)))
gene=lapply(sample,get_exon_count)
#names(gene) = c('19','CP1','CP2','CP3','CP4','MCP1','FCP1')
exclusion_exon = unlist(lapply(gene, get_element,i=1))
inclusion_exon = unlist(lapply(gene, get_element,i=2))
names(exclusion_exon)=c('19','CP1','CP2','CP3','CP4','MCP1','FCP1')
names(inclusion_exon)=c('19','CP1','CP2','CP3','CP4','MCP1','FCP1')
#load('/g/steinmetz/wmueller/NGLY1/gtf.rda')
#exclusion_gene_id = ids[ids$gene_name %in% exclusion_gene,c('gene_id','gene_name')]
#inclusion_gene_id = ids[ids$gene_name %in% inclusion_gene,c('gene_id','gene_name')]
ouFile = 'de_exon_exclusion_exon.txt'
file.create(ouFile)

for(i in 1:length(exclusion_exon))
{
    if(dim(exclusion_exon[[i]])[1]>0)
    { 
    x=exclusion_exon[[i]]
    y=data.frame(rownames(x),x$groupID,seqnames(x$genomicData),strand(x$genomicData),start(x$genomicData),end(x$genomicData),width(x$genomicData),names(exclusion_exon[i]))
    write.table(y, ouFile,append=T,quote=F,col.names=F,row.names=F)
    }
}

ouFile = 'de_exon_inclusion_exon.txt'
file.create(ouFile)

for(i in 1:length(inclusion_exon))
{
    if(dim(inclusion_exon[[i]])[1]>0)
    { 
    x=inclusion_exon[[i]]
    y=data.frame(rownames(x),x$groupID,seqnames(x$genomicData),strand(x$genomicData),start(x$genomicData),end(x$genomicData),width(x$genomicData),names(inclusion_exon[i]),x$countData)
    #names(y)=c('Exon-ID','Gene','chr','strand','start','end','width','sample','DMSO-rep1','DMSO-rep2','AzaC-rep1','AzaC-rep2')
    write.table(y, ouFile,append=T,quote=F,col.names=F,row.names=F,sep='\t')
    }
}



