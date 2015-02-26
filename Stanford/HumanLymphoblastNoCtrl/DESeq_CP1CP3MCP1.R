# test for DE in patient vs control group
# Author: czhu
###############################################################################
library(GenomicRanges)
library(DESeq2)

folder = "/g/steinmetz/hsun/Stanford/HumanLymphoblastNoCtrl"
outfolder = folder
if (!file.exists(outfolder))  dir.create(outfolder)

load(file.path(folder, "Counts-CP1CP3MCP1Ctrl.rda"))
load(file.path(folder, "SampleAnnot-CP1CP3MCP1Ctrl.rda"))
sampleAnnot$gender = rep(factor(c("female","male","female")),times=c(2,2,4))


## first look at gene counts
mat = assay(geneCounts)

## remove 19 for the moment and only consider the mock treated samples
#wh = which(sampleAnnot$individual != 19 & sampleAnnot$treatment == "DMSO")
#for patient specific analysis
#wh = which(grepl("^CP.*", sampleAnnot$individual) & sampleAnnot$treatment == "DMSO" )
##interfamily differences
#wh = which(sampleAnnot$family == "w" & sampleAnnot$treatment == "DMSO")
#CP2 v CP3
#wh = which(grepl("^[MCP1|CP1]", sampleAnnot$individual))
#wh = which(grepl("CP", sampleAnnot$individual))
wh=c(1,2,3,4,7,8)

sampleAnnot = droplevels(sampleAnnot[wh,])
rownames(sampleAnnot) = sampleAnnot$label
mat = mat[, wh]

#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sampleOrigin+ sampleStatus + treatment)
#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~gender + sampleStatus)
dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~gender+sampleStatus) #to compare CP2 and CP3 to CP1, unable to use family/gender difference, same comparison here
#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~gender+sampleStatus) #to compare CP2 and CP3 to CP1, unable to use family/gender difference, same comparison here
dds = DESeq(dds)

#dds = DESeq(dds, test="LRT", reduce=~treatment)
load("/g/steinmetz/hsun/Stanford/data/HumanGTF.rda")
res = results(dds)
res = cbind.data.frame(res, ids[match(rownames(res), ids$gene_id), c("gene_name","gene_biotype")])
res = res[order(res$padj), ]
res.sig=res[which(res$padj<0.05),]
res.sig.proteincoding = res.sig[res.sig$gene_biotype == "protein_coding",]
res.sig.proteincoding.up = res.sig.proteincoding[res.sig.proteincoding$log2FoldChange>=0,]
res.sig.proteincoding.down = res.sig.proteincoding[res.sig.proteincoding$log2FoldChange<0,]
res.sig.nonproteincoding = res.sig[res.sig$gene_biotype != "protein_coding",]


write.table( res, file=file.path(outfolder, "deCP1CP3MCP1.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
write.table( res.sig, file=file.path(outfolder, "deCP1CP3MCP1_sig.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
write.table( res.sig.proteincoding, file=file.path(outfolder, "deCP1CP3MCP1_sig_proteincoding.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
write.table( res.sig.proteincoding.up, file=file.path(outfolder, "deCP1CP3MCP1_sig_proteincoding_up.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
write.table( res.sig.proteincoding.down, file=file.path(outfolder, "deCP1CP3MCP1_sig_proteincoding_down.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
write.table( res.sig.nonproteincoding, file=file.path(outfolder, "deCP1CP3MCP1_sig_nonproteincoding.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)


rld = rlog(dds, blind=FALSE)
save(dds, rld, res,sampleAnnot,file=file.path(outfolder, "resCP1CP3vMCP1.rda"))


pdf(file.path(outfolder, "plot_PCA-deCP1CP3MCP1.pdf"), width=8, height=6)
print(plotPCA(rld, intgroup=c("individual", "sampleStatus")))
dev.off()

pdf(file.path(outfolder, "plot_MA-deCP1CP3MCP1.pdf"), width=8, height=6)
plotMA(results(dds), alpha=0.01)
dev.off()

pdf(file.path(outfolder, "plot_dispEst-deCP1CP3MCP1.pdf"), width=8, height=6)
plotDispEsts(dds)
dev.off()

