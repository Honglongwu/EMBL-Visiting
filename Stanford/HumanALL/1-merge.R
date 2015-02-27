library(DESeq2)
load('Counts-Human-Fibroblast.rda')
fibroblast=assay(geneCounts)
load('Counts-Human-Lymphoblast.rda')
lymphoblast=assay(geneCounts)
load('Counts-Human-iPS.rda')
ips=assay(geneCounts)

fibro.lympho=merge(fibroblast,lymphoblast,by.x=0,by.y=0)
fibro.lympho.ips = merge(fibro.lympho,ips,by.x=1,by.y=0)

geneCounts = fibro.lympho.ips[,2:dim(fibro.lympho.ips)[2]]
rownames(geneCounts)=fibro.lympho.ips[,1]

save(geneCounts, file = 'geneCounts-Human.rda' )
