library(DEXSeq)
load('/g/steinmetz/hsun/NGLY1/NGLY1-wmueller/exon-CP4/exonCounts-CP4.rda')
ec=assay(exonCounts)[unlist(exonicParts$gene_id == 'NGLY1'),]
rownames(ec)=paste('exon',1:14,sep="")
write.table(ec,'NGLY1-exon-counts',row.names=F,col.names=F)


print(lattice::dotplot(ec,]~rownames(ec),
                       group=rownames(ec),pch=19, auto.key=TRUE,
                       ylab="exon expression",main=g))


