library(DESeq2)

rt = read.table('Check-Gene-List')
colnames(rt) = c("Symbol","ID")

load('/g/steinmetz/hsun/NGLY1/NGLY1-wmueller/counts-BCells.rda')
data = assay(geneCounts)

