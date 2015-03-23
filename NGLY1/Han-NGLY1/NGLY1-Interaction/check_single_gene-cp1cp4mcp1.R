# check some control genes if the results are consisten with qPCR results
# Author: czhu
###############################################################################
library(DESeq2)

symbol2id = function(symbo){
    ids$gene_id[ids$gene_name==symbo]
}

folder = "/g/steinmetz/wmueller/NGLY1/"
load(file.path(folder, "gtf.rda"))
#load('DESeq-ALL-DMSO-rld.rda')
load('resCP1CP4MCP1.rda')
plotFolder=file.path("/g/steinmetz/hsun/NGLY1/Han-NGLY1/NGLY1-Interaction", "single-gene-plot-check")
if (!file.exists(plotFolder))  dir.create(plotFolder)

sampleAnnot$individual = factor(c('CP1','CP4','MCP1'))
rld= assay(rld)


geneplot = function(genename){
for(g in genename)
{
print(lattice::dotplot(rld[symbol2id(g),]~sampleAnnot$individual, 
                       group=sampleAnnot$individual,pch=19, auto.key=TRUE,
                       ylab="Normalised gene expression",main=g))
}
}

pdf(file.path(plotFolder, 'SOD2-CP1CP4MCP1.pdf'), width=8, height=6)
geneplot('SOD2')
dev.off()

pdf(file.path(plotFolder, 'GABARAPL1-CP1CP4MCP1.pdf'), width=8, height=6)
geneplot('GABARAPL1')
dev.off()

pdf(file.path(plotFolder, 'PACSIN2-CP1CP4MCP1.pdf'), width=8, height=6)
geneplot('PACSIN2')
dev.off()











#pdf(file.path(plotFolder, "b2m.pdf"), width=8, height=6)
#lattice::dotplot(assay(rld)["ENSG00000166710",]~sampleAnnot$individual, group=sampleAnnot$treatment,auto.key=TRUE,
#    pch=19, ylab="Normalised gene expression", main="Beta 2 microglobulin")
#dev.off()

#pdf(file.path(plotFolder, "srsf2.pdf"), width=8, height=6)
#lattice::dotplot(assay(rld)["ENSG00000161547",]~sampleAnnot$individual, group=sampleAnnot$treatment, auto.key=TRUE,
#    pch=19, ylab="Normalised gene expression", main="SRSF2")
#dev.off()

