library(DESeq2)
folder = '/g/steinmetz/hsun/Stanford'
load(file.path(folder,'HumanLymphoblastWithCtrl/Counts-Human-Lymphoblast.rda'))
load(file.path(folder,'HumanLymphoblastWithCtrl/sampleAnnot.rda'))
load(file.path(folder,'data/HumanGTF.rda'))


sampleAnnot = droplevels(sampleAnnot[c(1,2,3,4,5,6,7,8,9,10),])
rownames(sampleAnnot) = sampleAnnot$label

mat=assay(geneCounts)
mat = mat[, c(1,2,3,4,7,8,9,10,5,6)]

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
pdf(file.path(folder, paste0('/5-geneCheckUpdated/Human-Lymphoblast-Top10-',gene,'-Normalized-Expression.pdf')))
gn = unname(unlist(ddsed.norm[ids[ids$gene_name==gene,1,],]))
data = data.frame(sampleAnnot,gn)

print(lattice::dotplot(gn~factor(sample,level=c("Ctrl-B", "FCP1-B","MCP1-B","CP1-B","CP3-B")),group=factor(sampleStatus),data=data, auto.key=T, pch=19, ylab="Normalized gene expression",xlab=paste0(gene," in lymphoblast cells")))
dev.off()
}



#gene.plot("UCHL1")
#gene.plot("AK4")
#gene.plot("GAS6")

#gene.plot("ATF5")
#gene.plot("SPARC")
#gene.plot("ALDH1L2")
#gene.plot("VLDLR")
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


gene.plot("UCHL1")
gene.plot("DHRS9")
gene.plot("TNFRSF19")
gene.plot("SPARC")
gene.plot("TJP1")
gene.plot("EPHB1")
gene.plot("CNR1")
gene.plot("TNS3")
gene.plot("TBX15")
gene.plot("RAB38")


#gene = unname(unlist(ddsed.norm["ENSG00000154277",]))
#data = data.frame(sampleAnnot,gene)

#pdf(file.path(folder, '/5-geneCheck/Human-UCHL1-Normalized-Expression.pdf'))
#lattice::dotplot(gene~individual,data=data,group=sampleStatus, auto.key=T, pch=19, ylab="Gene Expression",xlab="UCHL1") 
#dev.off()
