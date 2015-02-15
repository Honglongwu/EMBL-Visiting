# test for DE in patient vs control group
# Author: czhu
###############################################################################
library(GenomicRanges)
library(DESeq2)

folder = "/g/steinmetz/hsun/Stanford/HumanLymphoblast"
outfolder = folder
if (!file.exists(outfolder))  dir.create(outfolder)

load(file.path(folder, "Counts-CP1CP3MCP1Ctrl.rda"))
load(file.path(folder, "SampleAnnot-CP1CP3MCP1Ctrl.rda"))

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
wh=c(1,2,3,4,7,8,5,6)

sampleAnnot = droplevels(sampleAnnot[wh,])
rownames(sampleAnnot) = sampleAnnot$label
mat = mat[, wh]

#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sampleOrigin+ sampleStatus + treatment)
#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~gender + sampleStatus)
dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sampleStatus) #to compare CP2 and CP3 to CP1, unable to use family/gender difference, same comparison here
#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~gender+sampleStatus) #to compare CP2 and CP3 to CP1, unable to use family/gender difference, same comparison here
dds = DESeq(dds)

#dds = DESeq(dds, test="LRT", reduce=~treatment)
load(file.path(folder, "gtf.rda"))
res = results(dds)
res = cbind.data.frame(res, ids[match(rownames(res), ids$gene_id), c("gene_name","gene_biotype")])
res = res[order(res$padj), ]

#..#write.table( res, file=file.path(outfolder, "deCP1vCP4.txt"), quote = FALSE, sep = "\t",  row.names = FALSE)
write.table( res, file=file.path(outfolder, "deCP1CP3MCP1Ctrl.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
res.sig=res[which(res$padj<0.01),]
write.table( res.sig, file=file.path(outfolder, "deCP1CP3MCP1Ctrl-0.01.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
res.sig=res[which(res$padj<0.05),]
write.table( res.sig, file=file.path(outfolder, "deCP1CP3MCP1Ctrl-0.05.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)

counts.norm = counts(dds, normalized=T)
cn = cbind.data.frame(ids[match(rownames(counts.norm), ids$gene_id), c("gene_name")],counts.norm)
colnames(cn)[1]='gene_symbol'
cn = cn[,c(1,2,3,4,5,8,9,6,7)]
write.table(cn, file="NGLY1-Gene-Normalized-Counts-Lymphoblast.txt",quote=F,sep="\t",row.names=T,col.names=NA)


rld = rlog(dds, blind=FALSE)
save(dds, rld, res,sampleAnnot,file=file.path(outfolder, "resCP1CP3vMCP1Ctrl.rda"))


pdf(file.path(outfolder, "plot_PCA-deCP1CP3MCP1Ctrl.pdf"), width=8, height=6)
print(plotPCA(rld, intgroup=c("individual", "sampleStatus")))
dev.off()

pdf(file.path(outfolder, "plot_MA-deCP1CP3MCP1Ctrl.pdf"), width=8, height=6)
plotMA(results(dds), alpha=0.01)
dev.off()

pdf(file.path(outfolder, "plot_dispEst-deCP1CP3MCP1Ctrl.pdf"), width=8, height=6)
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
