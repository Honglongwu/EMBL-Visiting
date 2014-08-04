folder='/g/steinmetz/wmueller/NGLY1/exon-CP4'
get_exon_count=function(inFile)
{
load(file.path(folder,inFile))
#ouFile = paste0(strsplit(inFile,'[.]')[[1]][1],'.exon.txt')
#cn=setdiff(colnames(dxr1),'genomicData')
#cn=c('groupID','featureID')
#exon=as.matrix(dxr1[dxr1$exonBaseMean==0,cn])
#exon=rownames(dxr1)[dxr1$exonBaseMean<=COUNT]
##rownames(dxr1[dxr1$padj<0.01 & !is.na(dxr1$padj),])
rownames(dxr1[dxr1$padj<0.01 & !is.na(dxr1$padj),])

#write.table(exon,ouFile,quote=F,col.names=F,row.names=F)
}
sample = c('DE_19.rda','DE_CP1.rda','DE_CP2.rda',
'DE_CP3.rda','DE_CP4.rda','DE_MCP1.rda','DE_FCP1.rda')
exon_unique = unique(unlist(lapply(sample,get_exon_count)))

get_exon_count=function(inFile,exon_unique)
{
load(file.path(folder,inFile))
#ouFile = paste0(strsplit(inFile,'[.]')[[1]][1],'.exon.txt')
#cn=setdiff(colnames(dxr1),'genomicData')
#cn=c('groupID','featureID')
#exon=as.matrix(dxr1[dxr1$exonBaseMean==0,cn])
exon_count=dxr1[exon_unique,]$countData
n = strsplit(inFile,'[_|.]')[[1]][2]
colnames(exon_count)=paste0(n,c('_AzaC_rep1','_AzaC_rep2','_DMSO_rep1','_DMSO_rep2'))
return(exon_count)

#write.table(exon,ouFile,quote=F,col.names=F,row.names=F)
}
exon_count=lapply(sample,get_exon_count,exon_unique=exon_unique)
df=data.frame(exon_count)
write.table(df,'sig_exon_count.txt',quote=F,col.names=NA)

