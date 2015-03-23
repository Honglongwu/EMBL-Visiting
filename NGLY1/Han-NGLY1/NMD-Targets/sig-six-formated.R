load('DESeq-treatment-control-pairwise.rda')
sig.gene.six = read.table('DE_treatment_six_samples.txt')[,1]
get.sig = function(x)
{
    y=x[rownames(x) %in% sig.gene.six,]
    write.table(y,paste0(unique(x$indi),'.six.txt'),quote=F,col.names=NA)
}

lapply(de.pw.indi.list,get.sig)

library(DESeq2)
load('counts-CP4.rda')
gc = assay(geneCounts)
count=gc[rownames(gc) %in% sig.gene.six,5:dim(gc)[2]]
write.table(count,'NGLY1-raw-count.txt',quote=F,col.names=NA)



