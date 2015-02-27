# test for DE in patient vs control group
# Author: czhu
###############################################################################
library(GenomicRanges)
library(DESeq2)

folder = "/g/steinmetz/hsun/Stanford/HumanFibroblastNoCtrl19"
outfolder = folder
#outfolder = file.path(folder, "NGLY1-groupwise-GeneLevel")
if (!file.exists(outfolder))  dir.create(outfolder)

load(file.path(folder, "Counts-Human-Fibroblast.rda"))
sampleAnnot = read.table('SampleAnnot.txt',head=T)

## first look at gene counts
mat = assay(geneCounts)

wh = seq(1,14)
sampleAnnot = droplevels(sampleAnnot[wh,])
sampleAnnot$sample = factor(sampleAnnot$sample, levels = c("FCP1","MCP1","CP1", "CP2","CP3","CP4","CP7"))
sampleAnnot$sampleStatus = relevel(sampleAnnot$sampleStatus,"control")
rownames(sampleAnnot) = sampleAnnot$label
mat = mat[, wh]

save(sampleAnnot,file = 'sampleAnnot.rda')

#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sampleOrigin+ sampleStatus + treatment)
#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~gender + sampleStatus)
#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~individual) #to compare CP2 and CP3 to CP1, unable to use family/gender difference, same comparison here
dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sample + gender) #to compare CP2 and CP3 to CP1, unable to use family/gender difference, same comparison here
dds = DESeq(dds)

#dds = DESeq(dds, test="LRT", reduce=~treatment)
load("/g/steinmetz/hsun/Stanford/data/HumanGTF.rda")
res = results(dds)
res = cbind.data.frame(res, ids[match(rownames(res), ids$gene_id), c("gene_name","gene_biotype")])
res = res[order(res$padj), ]
res.sig = res[which(res$padj<0.05 & res$baseMean > 20),]
res.sig.proteincoding = res.sig[res.sig$gene_biotype == "protein_coding",]
res.sig.proteincoding.up = res.sig.proteincoding[res.sig.proteincoding$log2FoldChange>=0,]
res.sig.proteincoding.down = res.sig.proteincoding[res.sig.proteincoding$log2FoldChange<0,]
res.sig.nonproteincoding = res.sig[res.sig$gene_biotype != "protein_coding",]

#..#write.table( res, file=file.path(outfolder, "deCP1vCP4.nogender.txt"), quote = FALSE, sep = "\t",  row.names = FALSE)
write.table( res, file=file.path(outfolder, "deFibroblast.nogender.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
write.table( res.sig, file=file.path(outfolder, "deFibroblast_sig.nogender.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
write.table( res.sig.proteincoding, file=file.path(outfolder, "deFibroblast_sig_proteincoding.nogender.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
write.table( res.sig.proteincoding.up, file=file.path(outfolder, "deFibroblast_sig_proteincoding_up.nogender.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
write.table( res.sig.proteincoding.down, file=file.path(outfolder, "deFibroblast_sig_proteincoding_down.nogender.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
write.table( res.sig.nonproteincoding, file=file.path(outfolder, "deFibroblast_sig_nonproteincoding.nogender.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)

rld = rlog(dds, blind=FALSE)
save(dds, rld, res, res.sig,res.sig.proteincoding,res.sig.nonproteincoding,sampleAnnot,file=file.path(outfolder, "resFibroblast.rda"))

pdf(file.path(outfolder, "plot_PCA-deFibroblast.pdf"), width=8, height=6)
print(plotPCA(rld, intgroup=c("sample", "sampleStatus")))
dev.off()

pdf(file.path(outfolder, "plot_MA-deFibroblast.pdf"), width=8, height=6)
plotMA(results(dds), alpha=0.01)
dev.off()

pdf(file.path(outfolder, "plot_dispEst-deFibroblast.pdf"), width=8, height=6)
plotDispEsts(dds)
dev.off()


Counts.norm = counts(dds, normalized=T)
save(Counts.norm, file = "Counts-Normalized-Human-Fibroblast.rda")
cn = cbind.data.frame(ids[match(rownames(Counts.norm), ids$gene_id), c("gene_name")],Counts.norm)
colnames(cn)[1]='gene_symbol'
write.table(cn, file="Human-Fibroblast-Normalized-Counts.nogender.txt",quote=F,sep="\t",row.names=T,col.names=NA)

counts.norm = counts(dds, normalized=F)
cn = cbind.data.frame(ids[match(rownames(counts.norm), ids$gene_id), c("gene_name")],counts.norm)
colnames(cn)[1]='gene_symbol'
write.table(cn, file="Counts-Human-Fibroblast.nogender.txt",quote=F,sep="\t",row.names=T,col.names=NA)
