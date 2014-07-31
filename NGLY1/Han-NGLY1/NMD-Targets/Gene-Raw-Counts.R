library(DESeq2)
load('counts-CP4.rda')
x=assay(geneCounts)
PTGS2=x[rownames(x)=='ENSG00000073756',]
getname=function(x){s=unlist(strsplit(x,'[.]'));return(s[1])}
names(PTGS2)=sapply(names(PTGS2),getname)
write.table(PTGS2,'NMD-Target-Gene.txt',quote=F,col.names=F)

PTGS2=x[rownames(x)=='ENSG00000151012',]
getname=function(x){s=unlist(strsplit(x,'[.]'));return(s[1])}
names(PTGS2)=sapply(names(PTGS2),getname)
write.table(PTGS2,'NMD-Target-Gene.txt',quote=F,col.names=F,append=T)
