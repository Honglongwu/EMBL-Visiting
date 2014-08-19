# check some control genes if the results are consisten with qPCR results
# Author: czhu
###############################################################################
library(DESeq2)

symbol2id = function(symbo){
    ids$gene_id[ids$gene_name==symbo]
}

folder = "/g/steinmetz/wmueller/NGLY1/"
load(file.path(folder, "gtf.rda"))
load(file.path(folder, "counts-CP4.rda"))
load(file.path(folder, "sampleAnnot-CP4.rda"))
load('resNGLY1-ALL.rda')
#load('resCP1CP4MCP1.rda')

gc.name = colnames(assay(geneCounts))
gc.name = gc.name[grepl('CP.*DMSO', gc.name)]
gc = assay(geneCounts)[,gc.name]
gc.annot=factor(c('CP1','CP1','CP2','CP2','CP3','CP3','CP4','CP4','FCP1','FCP1','MCP1','MCP1'))


plotFolder=file.path("/g/steinmetz/hsun/NGLY1/Han-NGLY1/NGLY1-Interaction", "single-gene-plot-check")
if (!file.exists(plotFolder))  dir.create(plotFolder)

#sampleAnnot$individual = factor(c('CP1','CP4','MCP1'))
geneplot = function(genename){
for(g in genename)
{
print(lattice::dotplot(gc[symbol2id(g),]~gc.annot, 
                       group=gc.annot,pch=19, auto.key=TRUE,
                       ylab="gene raw counts",main=g))
}
}

pdf(file.path(plotFolder, 'SOD2-all-raw.pdf'), width=8, height=6)
geneplot('SOD2')
dev.off()







#pdf(file.path(plotFolder, "b2m.pdf"), width=8, height=6)
#lattice::dotplot(assay(rld)["ENSG00000166710",]~sampleAnnot$individual, group=sampleAnnot$treatment,auto.key=TRUE,
#    pch=19, ylab="Normalised gene expression", main="Beta 2 microglobulin")
#dev.off()

#pdf(file.path(plotFolder, "srsf2.pdf"), width=8, height=6)
#lattice::dotplot(assay(rld)["ENSG00000161547",]~sampleAnnot$individual, group=sampleAnnot$treatment, auto.key=TRUE,
#    pch=19, ylab="Normalised gene expression", main="SRSF2")
#dev.off()

