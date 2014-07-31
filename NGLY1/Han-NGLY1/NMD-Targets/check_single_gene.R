# check some control genes if the results are consisten with qPCR results
# Author: czhu
###############################################################################
##..##library(GenomicRanges)
library(DESeq2)

folder = "/g/steinmetz/wmueller/NGLY1/"
load(file.path(folder, "counts-CP4.rda"))
load(file.path(folder, "sampleAnnot-CP4.rda"))
load(file.path(folder, "gtf.rda"))
##..##
##..#### first look at gene counts
##..##mat = assay(geneCounts)
##..##
##..##dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~ individual + treatment)
##..##dds = DESeq(dds)
##..##
##..##rld = assay(rlog(dds, blind=FALSE))
##..##save(rld, file='DESeq-ALL-rld.rda')
symbol2id = function(symbo){
    ids$gene_id[ids$gene_name==symbo]
}

load('DESeq-ALL-rld.rda')
plotFolder=file.path("/g/steinmetz/hsun/NGLY1/Han-NGLY1/NMD-Targets", "single-gene-plot-check")
if (!file.exists(plotFolder))  dir.create(plotFolder)
sampleAnnot$individual = factor(c('19','CP1','CP2','CP3','CP4','MCP1','FCP1'))

xxplot = function(genename){
#filename = paste0(gene,'.pdf')
#filename = 'haha.pdf'
pdf(file.path(plotFolder, "haha.pdf"), width=8, height=6)
p=lattice::dotplot(rld[symbol2id(genename),]~sampleAnnot$individual, group=sampleAnnot$treatment,pch=19, auto.key=TRUE,ylab="Normalised gene expression")
dev.off()
}
xxplot('NGLY1')


#pdf(file.path(plotFolder, "b2m.pdf"), width=8, height=6)
#lattice::dotplot(assay(rld)["ENSG00000166710",]~sampleAnnot$individual, group=sampleAnnot$treatment,auto.key=TRUE,
#    pch=19, ylab="Normalised gene expression", main="Beta 2 microglobulin")
#dev.off()

#pdf(file.path(plotFolder, "srsf2.pdf"), width=8, height=6)
#lattice::dotplot(assay(rld)["ENSG00000161547",]~sampleAnnot$individual, group=sampleAnnot$treatment, auto.key=TRUE,
#    pch=19, ylab="Normalised gene expression", main="SRSF2")
#dev.off()

