# 
# Author: czhu
###############################################################################
library(GenomicRanges)
library(DESeq2)

folder = "/g/steinmetz/wmueller/NGLY1/"
load(file.path(folder, "counts-CP4.rda"))
load(file.path(folder, "sampleAnnot-CP4.rda"))

outfolder = file.path(folder, "drug_in_patient-CP4")
if (!file.exists(outfolder))  dir.create(outfolder)

## first look at gene counts
mat = assay(geneCounts)
## remove 19 for the moment
wh = which(sampleAnnot$individual != 19 )
sampleAnnot = droplevels(sampleAnnot[wh,])
mat = mat[, wh]
# if has effect in patient, essential interaction between treatment and samplestatus but only in 1 group
sampleAnnot$hasEffect= factor(ifelse(sampleAnnot$treatment == "AzaC_20uM" & sampleAnnot$sampleStatus== "patient", "yes", "no"), c("no","yes"))

#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sampleOrigin+ sampleStatus + treatment)
dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~individual + treatment+  hasEffect)
dds = DESeq(dds)

load(file.path(folder, "gtf.rda"))
res = results(dds)
res = cbind.data.frame(res, ids[match(rownames(res), ids$gene_id), c("gene_name","gene_biotype")])

res = res[order(res$padj), ]
write.table( res, file=file.path(outfolder, "de.txt"), quote = FALSE, sep = "\t",  row.names = FALSE)

rld = rlog(dds, blind=FALSE)
save(dds, rld, res, sampleAnnot, file=file.path(outfolder, "res.rda"))

cat("Genes show specific effect")
pdf(file.path(outfolder, "affected_genes.pdf"), width=8, height=6)
lattice::dotplot(assay(rld)["ENSG00000154277",]~sampleAnnot$individual, group=sampleAnnot$treatment, auto.key=TRUE,
    pch=19, ylab="Normalised gene expression",main="UCHL1")
lattice::dotplot(assay(rld)["ENSG00000111371",]~sampleAnnot$individual, group=sampleAnnot$treatment, auto.key=TRUE,
    pch=19, ylab="Normalised gene expression", main="SLC38A1")
dev.off()


pdf(file.path(outfolder, "plot_PCA.pdf"), width=8, height=6)
print(plotPCA(rld, intgroup=c("individual", "sampleStatus")))
dev.off()

pdf(file.path(outfolder, "plot_MA.pdf"), width=8, height=6)
plotMA(res, alpha=0.01)
dev.off()

pdf(file.path(outfolder, "plot_dispEst.pdf"), width=8, height=6)
plotDispEsts(dds)
dev.off()

#
#rld = rlog(dds, blind=FALSE)
#print(plotPCA(rld, intgroup=c("individual", "sampleStatus")))


