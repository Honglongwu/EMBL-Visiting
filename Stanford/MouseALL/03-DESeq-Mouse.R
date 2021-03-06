# test for DE in patient vs control group
# Author: czhu
###############################################################################
library(DESeq2)

folder = "/g/steinmetz/hsun/Stanford/MouseALL"
outfolder = folder
#outfolder = file.path(folder, "NGLY1-groupwise-GeneLevel")
if (!file.exists(outfolder))  dir.create(outfolder)

load(file.path(folder, "geneCounts-Mouse.rda"))
sampleAnnot = read.table('sampleAnnot-Mouse.txt',head=T)
wh = seq(1,11)
sampleAnnot = droplevels(sampleAnnot[wh,])
sampleAnnot$sampleStatus = relevel(sampleAnnot$sampleStatus,"WT")
rownames(sampleAnnot) = sampleAnnot$label
geneCounts = geneCounts[,wh]

save(sampleAnnot,file = 'sampleAnnot-Mouse.rda')

#dds = DESeqDataSetFromMatrix(geneCounts, sampleAnnot, design=~cellType+individual+gender+sampleStatus) #to compare CP2 and CP3 to CP1, unable to use family/gender difference, same comparison here
dds = DESeqDataSetFromMatrix(geneCounts, sampleAnnot, design=~cellType+sampleStatus) #to compare CP2 and CP3 to CP1, unable to use family/gender difference, same comparison here
dds = DESeq(dds)

#dds = DESeq(dds, test="LRT", reduce=~treatment)
load("/g/steinmetz/hsun/Stanford/data/MouseGenome/MouseGTF.rda")
res = results(dds)
res = cbind.data.frame(res, ids[match(rownames(res), ids$gene_id), c("gene_name","gene_biotype")])
res = res[order(res$padj), ]
res.sig = res[which(res$padj<0.05 & res$baseMean > 20),]
res.sig.proteincoding = res.sig[res.sig$gene_biotype == "protein_coding",]
res.sig.proteincoding.up = res.sig.proteincoding[res.sig.proteincoding$log2FoldChange>=0,]
res.sig.proteincoding.down = res.sig.proteincoding[res.sig.proteincoding$log2FoldChange<0,]
res.sig.nonproteincoding = res.sig[res.sig$gene_biotype != "protein_coding",]

#..#write.table( res, file=file.path(outfolder, "deCP1vCP4.txt"), quote = FALSE, sep = "\t",  row.names = FALSE)
write.table( res, file=file.path(outfolder, "deNGLY1-PrimaryP4ImmortP3.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
write.table( res.sig, file=file.path(outfolder, "deNGLY1-PrimaryP4ImmortP3_sig.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
write.table( res.sig.proteincoding, file=file.path(outfolder, "deNGLY1-PrimaryP4ImmortP3_sig_proteincoding.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
write.table( res.sig.proteincoding.up, file=file.path(outfolder, "deNGLY1-PrimaryP4ImmortP3_sig_proteincoding_up.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
write.table( res.sig.proteincoding.down, file=file.path(outfolder, "deNGLY1-PrimaryP4ImmortP3_sig_proteincoding_down.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)
write.table( res.sig.nonproteincoding, file=file.path(outfolder, "deNGLY1-PrimaryP4ImmortP3_sig_nonproteincoding.txt"), quote = FALSE, sep = "\t",  row.names = T, col.names=NA)

rld = rlog(dds, blind=FALSE)
save(dds, rld, res, res.sig,res.sig.proteincoding,res.sig.nonproteincoding,sampleAnnot,file=file.path(outfolder, "resNGLY1.rda"))

pdf(file.path(outfolder, "plot_PCA-deNGLY1-PrimaryP4ImmortP3.pdf"), width=8, height=6)
print(plotPCA(rld, intgroup=c("sampleStatus","cellType")))
dev.off()

pdf(file.path(outfolder, "plot_MA-deNGLY1-PrimaryP4ImmortP3.pdf"), width=8, height=6)
plotMA(results(dds), alpha=0.01)
dev.off()

pdf(file.path(outfolder, "plot_dispEst-deNGLY1-PrimaryP4ImmortP3.pdf"), width=8, height=6)
plotDispEsts(dds)
dev.off()


geneCounts.norm = counts(dds, normalized=T)
cn = cbind.data.frame(ids[match(rownames(geneCounts.norm), ids$gene_id), c("gene_name")],geneCounts.norm)
colnames(cn)[1]='gene_symbol'
write.table(cn, file="geneCounts-Mouse-PrimaryP4ImmortP3-Normalized.txt",quote=F,sep="\t",row.names=T,col.names=NA)
save(geneCounts.norm, file = "geneCounts-Mouse-PrimaryP4ImmortP3-Normalized.rda")

geneCounts.norm = counts(dds, normalized=F)
cn = cbind.data.frame(ids[match(rownames(geneCounts.norm), ids$gene_id), c("gene_name")],geneCounts.norm)
colnames(cn)[1]='gene_symbol'
write.table(cn, file="geneCounts-Mouse-PrimaryP4ImmortP3-raw.txt",quote=F,sep="\t",row.names=T,col.names=NA)
