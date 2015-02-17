library(GenomicRanges)
library(DESeq2)

SIG = 0.05
folder = "/g/steinmetz/hsun/Stanford"

outfolder = file.path(folder, "3-DESeq")
if (!file.exists(outfolder))  dir.create(outfolder)

load(file.path(folder, "Counts-Mouse-2014-1011.rda"))
load(file.path(folder,'data/MouseGenome/MouseGTF.rda'))
pdx=unique(pd[,c("sample","biorep","passage","label")])

re = '.*(NGLY1-KO|WT).*immortP5'
cmp = "NGLY1-KO_WT_immortP5"

sampleAnnot=pdx[grepl(re,pdx$label),]
sampleAnnot$sample = factor(rep(c("Ngly1-KO","WT"),times=c(2,3)), levels = c("WT","Ngly1-KO"))

mat = assay(geneCounts)
mat = mat[, grepl(re,colnames(geneCounts))]

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
pdf(file.path(folder, paste0('/5-geneCheck/Mouse-immortP5-',gene,'-Normalized-Expression.pdf')))
gn = unname(unlist(ddsed.norm[ids[ids$gene_name==gene,1,][1],]))
data = data.frame(sampleAnnot,gn)

print(lattice::dotplot(gn~sample,group=sample,data=data, auto.key=T, pch=19, ylab="Normalized gene expression",xlab=paste0(gene," in immortP5 cells")))
dev.off()
}

gene.plot("Gas6")
gene.plot("Ak4")

gene.plot("Atf5")
gene.plot("Sparc")
gene.plot("Aldh1l2")
gene.plot("Vldlr")

#gene = unname(unlist(ddsed.norm["ENSG00000154277",]))
#data = data.frame(sampleAnnot,gene)

#pdf(file.path(folder, '/5-geneCheck/Human-UCHL1-Normalized-Expression.pdf'))
#lattice::dotplot(gene~individual,data=data,group=sampleStatus, auto.key=T, pch=19, ylab="Gene Expression",xlab="UCHL1") 
#dev.off()
