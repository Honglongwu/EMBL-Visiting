folder='/g/steinmetz/wmueller/NGLY1/exon-CP4'
COUNT=0
get_exon=function(inFile)
{
load(inFile)
ouFile = paste0(strsplit(inFile,'[.]')[[1]][1],'.exon.txt')
#cn=setdiff(colnames(dxr1),'genomicData')
#cn=c('groupID','featureID')
#exon=as.matrix(dxr1[dxr1$exonBaseMean==0,cn])
exon=rownames(dxr1)[dxr1$exonBaseMean<=COUNT]
#write.table(exon,ouFile,quote=F,col.names=F,row.names=F)
}
sample = c('DE_19.rda','DE_CP1.rda','DE_CP2.rda',
'DE_CP3.rda','DE_CP4.rda','DE_MCP1.rda','DE_FCP1.rda')
exon = lapply(sample, get_exon)
exon_unique=unique(unlist(exon))

get_exon_count=function(inFile,exon_unique)
{
load(inFile)
#ouFile = paste0(strsplit(inFile,'[.]')[[1]][1],'.exon.txt')
#cn=setdiff(colnames(dxr1),'genomicData')
#cn=c('groupID','featureID')
#exon=as.matrix(dxr1[dxr1$exonBaseMean==0,cn])
exon=dxr1[exon_unique,'exonBaseMean']
return(exon)
#write.table(exon,ouFile,quote=F,col.names=F,row.names=F)
}
exon_count=lapply(sample,get_exon_count,exon_unique)


