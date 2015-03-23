library(DESeq2)
load('Counts-Mouse-PrimaryP4.rda')
primaryP4=assay(geneCounts)
load('Counts-Mouse-immortP3.rda')
immortP3=assay(geneCounts)
load('Counts-Mouse-immortP5.rda')
immortP5=assay(geneCounts)

primaryP4.immortP3=merge(primaryP4,immortP3,by.x=0,by.y=0)
primaryP4.immortP3.immortP5 = merge(primaryP4.immortP3,immortP5,by.x=1,by.y=0)

geneCounts = primaryP4.immortP3.immortP5[,2:dim(primaryP4.immortP3.immortP5)[2]]
rownames(geneCounts)=primaryP4.immortP3.immortP5[,1]

save(geneCounts, file = 'geneCounts-Mouse.rda' )
