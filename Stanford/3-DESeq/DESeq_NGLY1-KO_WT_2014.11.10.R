# test for DE in patient vs control group
# Author: czhu
###############################################################################
library(GenomicRanges)
library(DESeq2)

folder = "/g/steinmetz/hsun/Stanford"

outfolder = file.path(folder, "3-DESeq")
if (!file.exists(outfolder))  dir.create(outfolder)

load(file.path(folder, "Counts-Mouse-2014-1011.rda"))
pdx=unique(pd[,c("sample","biorep","passage","label")])
re = '.*(NGLY1-KO|WT).*2014.11.10'
sampleAnnot=pdx[grepl(re,pdx$label),]
sampleAnnot$sample = factor(sampleAnnot$sample, levels = c("WT","NGLY1-KO"))

mat = assay(geneCounts)
mat = mat[, grepl(re,colnames(geneCounts))]

dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sample)
dds = DESeq(dds)

#dds = DESeq(dds, test="LRT", reduce=~treatment)
load(file.path(folder, "gtf.rda"))
res = results(dds)
res = cbind.data.frame(res, ids[match(rownames(res), ids$gene_id), c("gene_name","gene_biotype")])
res = res[order(res$padj), ]

#..#write.table( res, file=file.path(outfolder, "deCP1vCP4.txt"), quote = FALSE, sep = "\t",  row.names = FALSE)
write.table( res, file=file.path(outfolder, "deCP1CP4.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)

rld = rlog(dds, blind=FALSE)
save(dds, rld, res,sampleAnnot,file=file.path(outfolder, "resCP1vCP4.rda"))

pdf(file.path(outfolder, "plot_PCA-deCP1CP4.pdf"), width=8, height=6)
print(plotPCA(rld, intgroup=c("individual", "sampleStatus")))
dev.off()

pdf(file.path(outfolder, "plot_MA-deCP1CP4.pdf"), width=8, height=6)
plotMA(results(dds), alpha=0.01)
dev.off()

pdf(file.path(outfolder, "plot_dispEst-deCP1CP4.pdf"), width=8, height=6)
plotDispEsts(dds)
dev.off()

#library("ReportingTools")
#desReport <- HTMLReport(shortName = 'RNAseq_analysis_with_DESeq',
#    title = 'RNA-seq analysis of differential expression using DESeq',reportDirectory = "./reports")
#res$id = df[match(rownames(res),df$ensembl_id),"gene_id"]
#
#publish(res,desReport,name="df",countTable=mat, pvalueCutoff=0.01,
#    conditions=sampleAnnot,annotation.db="org.Hs.eg.db",
#    expName="deseq",reportDir="./reports", .modifyDF=makeDESeqDF)
#finish(desReport)
