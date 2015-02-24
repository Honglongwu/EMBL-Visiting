# test for DE in patient vs control group
# Author: czhu
###############################################################################
library(GenomicRanges)
library(DESeq2)

SIG = 0.05
folder = "/g/steinmetz/hsun/Stanford/MousePrimaryP4"
outfolder = folder
if (!file.exists(outfolder))  dir.create(outfolder)

load(file.path(folder, "Counts-Mouse-primaryP4.rda"))
pdx=unique(pd[,c("sample","biorep","passage","label")])

re = '.*(NGLY1-KO|WT).*2014.10.21'
cmp = "NGLY1-KO_WT_2014.10.21"
#######
sampleAnnot=pdx[grepl(re,pdx$label),]
sampleAnnot$sample = factor(sampleAnnot$sample, levels = c("WT","NGLY1-KO"))

mat = assay(geneCounts)
mat = mat[, grepl(re,colnames(geneCounts))]

dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sample)
dds = DESeq(dds)

#dds = DESeq(dds, test="LRT", reduce=~treatment)
load(file.path(folder, "data/MouseGenome/MouseGTF.rda"))
res = results(dds)
res = cbind.data.frame(res, ids[match(rownames(res), ids$gene_id), c("gene_name","gene_biotype")])
res = res[order(res$padj), ]

#..#write.table( res, file=file.path(outfolder, "deCP1vCP4.txt"), quote = FALSE, sep = "\t",  row.names = FALSE)
write.table( res, file=file.path(outfolder, paste0("de_",cmp, ".txt")), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)

res.sig=res[which(res$padj<SIG),]

#..#write.table( res, file=file.path(outfolder, "deCP1vCP4.txt"), quote = FALSE, sep = "\t",  row.names = FALSE)
write.table( res.sig, file=file.path(outfolder, paste0("de_",cmp, ".sig.txt")), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)

rld = rlog(dds, blind=FALSE)
save(dds, rld, res,sampleAnnot,file=file.path(outfolder, paste0("res_",cmp,".rda")))

pdf(file.path(outfolder, paste0("plot-PCA_", cmp, ".pdf")), width=8, height=6)
print(plotPCA(rld, intgroup="sample"))
dev.off()

pdf(file.path(outfolder, paste0("plot-MA_",cmp, ".pdf")), width=8, height=6)
plotMA(results(dds), alpha=0.01)
dev.off()

pdf(file.path(outfolder,paste0("plot-dispEst_",cmp,".pdf")), width=8, height=6)
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
