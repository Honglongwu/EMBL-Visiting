folder='/g/steinmetz/wmueller/NGLY1/exon-CP4'
plotFolder = '/g/steinmetz/hsun/NGLY1/Han-NGLY1/NMD-Targets/Exon-exclusion/plot'
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
sig_exclusion = (sig_count[,1] <=0 & sig_count[,2]) <=0 | (sig_count[,3] <= 0 & sig_count[,4] <= 0)
for(gene in unqie(sig$groupID))
{
filename = paste0(gene,'.',strsplit(inFile,'[.]')[[1]][1],'.pdf')
pdf(file.path(plotFolder, filename), width=12, height=8)
for(thisExon in gene){
        plotDEXSeq( dxr1, thisExon, legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 ,displayTranscripts=TRUE,
                           fitExpToVar="treatment",norCounts=TRUE, splicing=TRUE)
}
dev.off()
}

#write.table(exon,ouFile,quote=F,col.names=F,row.names=F)
}
sample = c('DE_19.rda','DE_CP1.rda','DE_CP2.rda',
'DE_CP3.rda','DE_CP4.rda','DE_MCP1.rda','DE_FCP1.rda')
#exon_unique = unique(unlist(lapply(sample,get_exon_count)))
