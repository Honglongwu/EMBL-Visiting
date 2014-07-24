# check some control genes if the results are consisten with qPCR results
# Author: czhu
###############################################################################
library(GenomicRanges)
library(DESeq2)

folder = "/g/steinmetz/wmueller/NGLY1/"
load(file.path(folder, "counts.rda"))
load(file.path(folder, "sampleAnnot.rda"))

## first look at gene counts
mat = assay(geneCounts)

dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~ individual + treatment)
dds = DESeq(dds)

rld = rlog(dds, blind=FALSE)

plotFolder=file.path(folder, "single_gene_plots")
if (!file.exists(plotFolder))  dir.create(plotFolder)

pdf(file.path(plotFolder, "ngly1.pdf"), width=8, height=6)
lattice::dotplot(assay(rld)["ENSG00000151092",]~sampleAnnot$individual, group=sampleAnnot$treatment,pch=19, auto.key=TRUE, 
    ylab="Normalised gene expression", main="NGLY1")
dev.off()

pdf(file.path(plotFolder, "b2m.pdf"), width=8, height=6)
lattice::dotplot(assay(rld)["ENSG00000166710",]~sampleAnnot$individual, group=sampleAnnot$treatment,auto.key=TRUE,
    pch=19, ylab="Normalised gene expression", main="Beta 2 microglobulin")
dev.off()

pdf(file.path(plotFolder, "srsf2.pdf"), width=8, height=6)
lattice::dotplot(assay(rld)["ENSG00000161547",]~sampleAnnot$individual, group=sampleAnnot$treatment, auto.key=TRUE,
    pch=19, ylab="Normalised gene expression", main="SRSF2")
dev.off()

