library(DESeq2)

load('resNGLY1.rda')
load('/g/steinmetz/hsun/Stanford/data/HumanGTF.rda')
ddsed.norm = counts(dds,norm=T)
gene.plot=function(gene)
{
pdf(paste0(gene,'-Normalized-Expression.pdf'))
gn = unname(unlist(ddsed.norm[ids[ids$gene_name==gene,1,],]))
data = data.frame(sampleAnnot,gn)

print(lattice::dotplot(gn~individual|cellType,group=sampleStatus,data=data, auto.key=T, pch=19, ylab="Normalized gene expression",xlab=paste0(gene," in lymphoblast cells")))
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


gene.plot("NGLY1")
gene.plot("PSMB1")
gene.plot("PSMD1")
gene.plot("PSMD11")
gene.plot("PSMD14")
gene.plot("PSMC2")


#gene = unname(unlist(ddsed.norm["ENSG00000154277",]))
#data = data.frame(sampleAnnot,gene)

#pdf(file.path(folder, '/5-geneCheck/Human-UCHL1-Normalized-Expression.pdf'))
#lattice::dotplot(gene~individual,data=data,group=sampleStatus, auto.key=T, pch=19, ylab="Gene Expression",xlab="UCHL1") 
#dev.off()
