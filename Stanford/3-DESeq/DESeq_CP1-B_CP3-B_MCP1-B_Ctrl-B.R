# test for DE in patient vs control group
# Author: czhu
###############################################################################
library(GenomicRanges)
library(DESeq2)
SIG = 0.05
folder = "/g/steinmetz/hsun/Stanford"

outfolder = file.path(folder, "3-DESeq")
if (!file.exists(outfolder))  dir.create(outfolder)

load(file.path(folder, "Counts-Human-2014-1011.rda"))
pdx=unique(pd[,c("sample","biorep","passage","label")])
re = '.*(CP1-B|CP3-B|MCP1-B|Ctrl-B).*'
cmp = "CP1-B_CP3-B_MCP1-B_Ctrl-B"
sampleAnnot=pdx[grepl(re,pdx$label),]
sampleAnnot$sample = factor(sampleAnnot$sample, levels = c("Ctrl-B","MCP1-B","CP1-B", "CP3-B"))
sampleAnnot$cmp = factor(c("patient","patient","patient","patient","contrl","contrl","contrl","contrl"),level=c("contrl","patient"))

mat = assay(geneCounts)
mat = mat[, grepl(re,colnames(geneCounts))]

dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~cmp)
dds = DESeq(dds)

#dds = DESeq(dds, test="LRT", reduce=~treatment)
load(file.path(folder, "data/HumanGTF.rda"))
res = results(dds)
res = cbind.data.frame(res, ids[match(rownames(res), ids$gene_id), c("gene_name","gene_biotype")])
res = res[order(res$padj), ]
res.sig=res[which(res$padj<SIG),] 

#..#write.table( res, file=file.path(outfolder, "deCP1vCP4.txt"), quote = FALSE, sep = "\t",  row.names = FALSE)
write.table( res, file=file.path(outfolder, paste0("de_",cmp, ".txt")), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
write.table( res.sig, file=file.path(outfolder, paste0("de_",cmp, ".sig.txt")), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)

rld = rlog(dds, blind=FALSE)
save(dds, rld, res, res.sig,sampleAnnot,file=file.path(outfolder, paste0("res_",cmp,".rda")))

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
