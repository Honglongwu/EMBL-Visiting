library(DESeq2)
folder = '/g/steinmetz/hsun/Stanford'
load(file.path(folder,''))

load(file.path(folder,'data/HumanGTF.rda'))


ddsed.norm = counts(ddsed,norm=T)

#dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~sample)
#sf = estimateSizeFactors(dds)
#mat.sf = mat/sizeFactors(sf)

gene.plot=function(gene)
{
pdf(file.path(folder, paste0('/5-geneCheck/Human-Lymphoblast-',gene,'-Normalized-Expression-with-Ctrl.pdf')))
gn = unname(unlist(ddsed.norm[ids[ids$gene_name==gene,1,],]))
data = data.frame(sampleAnnot,gn)

print(lattice::dotplot(gn~factor(individual,level=c("Ctrl-B","MCP1-B","CP1-B","CP3-B")),group=factor(sampleStatus),data=data, auto.key=T, pch=19, ylab="Normalized gene expression",xlab=paste0(gene," in lymphoblast cells")))
dev.off()
}



#gene.plot("UCHL1")
#gene.plot("AK4")
#gene.plot("GAS6")

#gene.plot("ATF5")
#gene.plot("SPARC")
#gene.plot("ALDH1L2")
#gene.plot("VLDLR")
gene.plot("GPC4")


#gene = unname(unlist(ddsed.norm["ENSG00000154277",]))
#data = data.frame(sampleAnnot,gene)

#pdf(file.path(folder, '/5-geneCheck/Human-UCHL1-Normalized-Expression.pdf'))
#lattice::dotplot(gene~individual,data=data,group=sampleStatus, auto.key=T, pch=19, ylab="Gene Expression",xlab="UCHL1") 
#dev.off()
