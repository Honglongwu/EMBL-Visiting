library(DESeq2)
folder = '/g/steinmetz/hsun/Stanford'
load(file.path(folder,'HumanFibroblastNoCtrl19/Counts-Human-Fibroblast.rda'))
load(file.path(folder,'HumanFibroblastNoCtrl19/sampleAnnot.rda'))

load(file.path(folder,'data/HumanGTF.rda'))



wh = seq(1,14)
sampleAnnot = droplevels(sampleAnnot[wh,])
sampleAnnot$sample = factor(sampleAnnot$sample, levels = c("FCP1","MCP1","CP1", "CP2","CP3","CP4","CP7"))
rownames(sampleAnnot) = sampleAnnot$label

mat=assay(geneCounts)
mat = mat[, wh]

#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sampleOrigin+ sampleStatus + treatment)
#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~gender + sampleStatus)
#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~individual) #to compare CP2 and CP3 to CP1, unable to use family/gender difference, same comparison here
dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~gender+sampleStatus) #to compare CP2 and CP3 to CP1, unable to use family/gender difference, same comparison here
ddsed = DESeq(dds)
ddsed.norm = counts(ddsed,norm=T)

#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sample)
#sf = estimateSizeFactors(dds)
#mat.sf = mat/sizeFactors(sf)

gene.plot=function(gene)
{
pdf(file.path(folder, paste0('/5-geneCheckUpdated/Human-Fibroblast-Top10-',gene,'-Normalized-Expression.pdf')))
gn = unname(unlist(ddsed.norm[ids[ids$gene_name==gene,1,],]))
data = data.frame(sampleAnnot,gn)

print(lattice::dotplot(gn~sample,group=sampleStatus,data=data, auto.key=T, pch=19, ylab="Normalized gene expression",xlab=paste0(gene," in fibroblast cells")))
dev.off()
}



#gene.plot("UCHL1")
#gene.plot("DYNC1H1")
#gene.plot("GAS6")
#gene.plot("AK4")
#gene.plot("GPC2")
#gene.plot("NGLY1")
#gene.plot("HOXB3")
#gene.plot("SOX4")
#gene.plot("GRPR")
#gene.plot("TNS3")
#gene.plot("MARCKSL1")
#gene.plot("MOXD1")
#gene.plot("INPP4B")
#gene.plot("UCHL1")
#gene.plot("RBPJ")
#gene.plot("GPC3")
#gene.plot("FBN2")
#gene.plot("TSPAN11")
#gene.plot("CCDC8")
#gene.plot("HOXB3")
#gene.plot("ST3GAL5")
#gene.plot("HOXC5")
#gene.plot("ABI3BP")
#gene.plot("HMOX1")
#gene.plot("WISP2")
#gene.plot("CRLF1")

#gene.plot("UCHL1")
#gene.plot("DHRS9")
#gene.plot("TNFRSF19")
#gene.plot("SPARC")
#gene.plot("TJP1")
#gene.plot("EPHB1")
#gene.plot("CNR1")
#gene.plot("TNS3")
#gene.plot("TBX15")
#gene.plot("RAB38")

gene.plot("ABI3BP")
gene.plot("HMOX1")
gene.plot("WISP2")
gene.plot("CRLF1")
gene.plot("FAM212B")
gene.plot("PIWIL2")
gene.plot("FBN2")
gene.plot("TSPAN11")
gene.plot("CCDC8")
gene.plot("HOXB3")

