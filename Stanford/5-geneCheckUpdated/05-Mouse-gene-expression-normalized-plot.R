library(GenomicRanges)
library(DESeq2)

SIG = 0.05
folder = "/g/steinmetz/hsun/Stanford"

outfolder = file.path(folder, "5")
if (!file.exists(outfolder))  dir.create(outfolder)

load(file.path(folder, "MousePrimaryP4/Counts-Mouse-PrimaryP4.rda"))
load(file.path(folder, "MousePrimaryP4/sampleAnnot.rda"))
load(file.path(folder,'data/MouseGenome/MouseGTF.rda'))


mat = assay(geneCounts)
mat = mat[,c(1,2,3,4,5,6)] 

dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sample)

#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sampleOrigin+ sampleStatus + treatment)
#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~gender + sampleStatus)
#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~individual) #to compare CP2 and CP3 to CP1, unable to use family/gender difference, same comparison here
ddsed = DESeq(dds)
ddsed.norm = counts(ddsed,norm=T)

#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sample)
#sf = estimateSizeFactors(dds)
#mat.sf = mat/sizeFactors(sf)

gene.plot=function(gene)
{
pdf(file.path(folder, paste0('/5-geneCheckUpdated/Mouse-primaryP4-',gene,'-Normalized-Expression.pdf')))
gn = unname(unlist(ddsed.norm[ids[ids$gene_name==gene,1,][1],]))
data = data.frame(sampleAnnot,gn)

print(lattice::dotplot(gn~sample,group=sample,data=data, auto.key=T, pch=19, ylab="Normalized gene expression",xlab=paste0(gene," in primaryP4 cells")))
dev.off()
}

#gene.plot("Gas6")
#gene.plot("Ak4")

#gene.plot("Atf5")
#gene.plot("Sparc")
#gene.plot("Aldh1l2")
#gene.plot("Vldlr")
gene.plot("Gpc4")
gene.plot("Marcksl1")


#gene = unname(unlist(ddsed.norm["ENSG00000154277",]))
#data = data.frame(sampleAnnot,gene)

#pdf(file.path(folder, '/5-geneCheck/Human-UCHL1-Normalized-Expression.pdf'))
#lattice::dotplot(gene~individual,data=data,group=sampleStatus, auto.key=T, pch=19, ylab="Gene Expression",xlab="UCHL1") 
#dev.off()
