library(DESeq2)
library(gplots)

load('resNGLY1.rda')
up = read.table('deNGLY1_sig_proteincoding_up.txt', head=T)
down = read.table('deNGLY1_sig_proteincoding_down.txt', head=T)
sig = c(rownames(up),rownames(down))
rld = assay(rld)
sig.rld = rld[sig,]
heatmap.2(sig.rld,scale="row",trace="none",dendrogram="none")
