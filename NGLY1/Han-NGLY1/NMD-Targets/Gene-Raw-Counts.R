library(DESeq2)
folder = "/g/steinmetz/wmueller/NGLY1/"
load(file.path(folder, "counts-CP4.rda"))
load(file.path(folder, "sampleAnnot-CP4.rda"))
load(file.path(folder, "gtf.rda"))
symbol2id = function(symbo){
        ids$gene_id[ids$gene_name==symbo]
}




x=assay(geneCounts)
PTGS2=x[rownames(x)=='ENSG00000073756',]
getname=function(x){s=unlist(strsplit(x,'[.]'));return(s[1])}
names(PTGS2)=sapply(names(PTGS2),getname)
#write.table(PTGS2,'NMD-Target-Gene.txt',quote=F,col.names=F)

PTGS2=x[rownames(x)=='ENSG00000151012',]
getname=function(x){s=unlist(strsplit(x,'[.]'));return(s[1])}
names(PTGS2)=sapply(names(PTGS2),getname)
#write.table(PTGS2,'NMD-Target-Gene.txt',quote=F,col.names=F,append=T)

