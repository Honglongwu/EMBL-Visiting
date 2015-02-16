library(DESeq2)
folder = '/g/steinmetz/hsun/Stanford'
load(file.path(folder,'HumanFibroblast/Counts-CP1CP2CP3CP4FCP1MCP1Ctrl19.rda'))
load(file.path(folder,'HumanFibroblast/SampleAnnot-CP1CP2CP3CP4FCP1MCP1Ctrl19.rda'))

load(file.path(folder,'data/HumanGTF.rda'))


wh = c(7,8,11,12,15,16,19,20,23,24,27,28,3,4)

sampleAnnot = droplevels(sampleAnnot[wh,])
sampleAnnot$individual=relevel(sampleAnnot$individual,'FCP1')
rownames(sampleAnnot) = sampleAnnot$label

mat=assay(geneCounts)
mat = mat[, wh]

#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sampleOrigin+ sampleStatus + treatment)
#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~gender + sampleStatus)
#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~individual) #to compare CP2 and CP3 to CP1, unable to use family/gender difference, same comparison here
dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sampleStatus+gender) #to compare CP2 and CP3 to CP1, unable to use family/gender difference, same comparison here
ddsed = DESeq(dds)
ddsed.norm = counts(ddsed,norm=T)

#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sample)
#sf = estimateSizeFactors(dds)
#mat.sf = mat/sizeFactors(sf)

pdf(file.path(folder, '/5-geneCheck/Human-USP9Y-Normalized-Expression.pdf'))
gene = unname(unlist(ddsed.norm["ENSMUSG00000021785",]))
data = data.frame(sampleAnnot,gene)

lattice::dotplot(condition~gene|passage,data=data, auto.key=T, pch=19, xlab="Gene Expression",ylab="Ngly1") 
dev.off()
