# 
# Author: czhu
###############################################################################
library(GenomicRanges)
library(DESeq2)

folder = "/g/steinmetz/wmueller/NGLY1/"
load(file.path(folder, "counts-CP4.rda"))
load(file.path(folder, "sampleAnnot-CP4.rda"))

outfolder = file.path(folder, "drug-effect-groupwise-GeneLevel")
if (!file.exists(outfolder))  dir.create(outfolder)

## first look at gene counts
mat = assay(geneCounts)

## try only CP1
#wh = which(sampleAnnot$individual == "CP1" )
#sampleAnnot = droplevels(sampleAnnot[wh,])
#mat = mat[, wh]
#
##dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sampleOrigin+ sampleStatus + treatment)
#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~treatment)
#dds = DESeq(dds)

################################################################################

## remove 19 for the moment
wh = which(sampleAnnot$individual != 19 )
sampleAnnot = droplevels(sampleAnnot[wh,])
mat = mat[, wh]

#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sampleOrigin+ sampleStatus + treatment)
dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~individual + treatment)
dds = DESeq(dds)

load(file.path(folder, "gtf.rda"))
res = results(dds)
res = cbind.data.frame(res, ids[match(rownames(res), ids$gene_id), c("gene_name","gene_biotype")])

## get NMD list
#require(biomaRt)
#ensembl = useMart("ensembl",dataset="hsapiens_gene_ensembl")
#nmdAnnot = getBM(attributes=c('ensembl_gene_id', "transcript_biotype"), filters='ensembl_gene_id', values=rownames(res), mart=ensembl)
#nmdAnnot = droplevels(subset(nmdAnnot, transcript_biotype=="nonsense_mediated_decay"))
#save(nmdAnnot, file=file.path(folder, "nmdAnnot.rda"))

cat("number of testable genes\n")
sum(!is.na(res$padj))
cat("number of signicant genes\n")
sum(res$padj< 0.001, na.rm=TRUE)

res = res[order(res$padj), ]
write.table( res, file=file.path(outfolder, "de.txt"), quote = FALSE, sep = "\t",  row.names = FALSE)
write.table( res, file=file.path(outfolder, "drug-effect-six-sample.txt"), quote = FALSE, sep = "\t")

rld = rlog(dds, blind=FALSE)
save(dds, rld, res, sampleAnnot, file=file.path(outfolder, "res.rda"))

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


