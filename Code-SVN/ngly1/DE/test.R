# TODO: pairwise comparison between treat and control
# 
# Author: xxb0316
###############################################################################
library(GenomicRanges)
library(DESeq2)
library(doMC)
registerDoMC(cores=5)
library(made4)
library(RColorBrewer)
library(pvclust)
library(VennDiagram)

folder = "/g/steinmetz/wmueller/NGLY1"
load(file.path(folder, "counts-CP4.rda"))
load(file.path(folder, "sampleAnnot-CP4.rda"))
load(file.path(folder, "gtf.rda"))

## first look at gene counts
mat = assay(geneCounts)

## remove 19 for the moment
#wh = which(sampleAnnot$individual != 19 )
#sampleAnnot = droplevels(sampleAnnot[wh,])
#mat = mat[, wh]

## pairwise comparison
pairwise.comp.func <- function(indi.name){
  
  mat.indi <- mat[,grepl(paste('^',indi.name,sep=''),colnames(mat))]
  dds = DESeqDataSetFromMatrix(mat.indi, sampleAnnot[sampleAnnot$individual == indi.name,], design=~treatment)
  dds = DESeq(dds)
  res = results(dds)
  res.df <- as.data.frame(res)
  res.df <- res.df[!is.na(res.df$padj),]
  res.df <- res.df[order(res.df$pvalue),]
  res.df$indi <- indi.name
  
  return(res.df)
  
}

de.pw.indi.list <- foreach(indi.name=unique(sampleAnnot$individual)) %dopar% pairwise.comp.func(indi.name)

outfolder="/g/steinmetz/wmueller/NGLY1/hcluster-CP4/" 

## find the shared up/down genes
## for up
venn.cols <- brewer.pal(12, 'Set3')[3:9]
up.gene.list <- lapply(de.pw.indi.list,function(x){rownames(subset(x,padj < 0.01 & log2FoldChange > 0))})
names(up.gene.list) <- unique(sampleAnnot$individual)

up.tmp <- venn.diagram(up.gene.list,filename=NULL,fill=venn.cols)
pdf(file.path(outdir,'venn.up.pdf'))
grid.draw(up.tmp)
dev.off()

down.gene.list <- lapply(de.pw.indi.list,function(x){rownames(subset(x,padj < 0.01 & log2FoldChange < 0))})
names(down.gene.list) <- unique(sampleAnnot$individual)

down.tmp <- venn.diagram(down.gene.list,filename=NULL,fill=venn.cols)
pdf(file.path(outfolder,'venn.down.pdf'))
grid.draw(down.tmp)
dev.off()

up.genes <- names(table(unlist(up.gene.list,use.name=FALSE)))[table(unlist(up.gene.list,use.name=FALSE)) == 5]
down.genes <- names(table(unlist(down.gene.list,use.name=FALSE)))[table(unlist(down.gene.list,use.name=FALSE)) == 5]
