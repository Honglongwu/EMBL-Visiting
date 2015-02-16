library(DESeq2)
folder = '/g/steinmetz/hsun/Stanford'
load(file.path(folder,'HumanFibroblast/Counts-CP1CP2CP3CP4FCP1MCP1Ctrl19.rda'))
load(file.path(folder,'HumanFibroblast/SampleAnnot-CP1CP2CP3CP4FCP1MCP1Ctrl19.rda'))

load(file.path(folder,'data/HumanGTF.rda'))



mat=assay(geneCounts)
dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sample)
sf = estimateSizeFactors(dds)
mat.sf = mat/sizeFactors(sf)

pdf(file.path(folder, '/5-geneCheck/Mouse-NGLY1-Normalized-Expression.pdf'))
gene = unname(unlist(mat.sf["ENSMUSG00000021785",]))
data = data.frame(sampleAnnot,gene)

lattice::dotplot(condition~gene|passage,data=data, auto.key=T, pch=19, xlab="Gene Expression",ylab="Ngly1") 
dev.off()
