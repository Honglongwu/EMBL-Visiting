library(DESeq2)

load('res_NGLY1-KO_WT.rda')
load('/g/steinmetz/hsun/Stanford/data/MouseGenome/MouseGTF.rda')
ddsed.norm = counts(dds,norm=T)

Ngly1 = unname(unlist(ddsed.norm[ids[ids$gene_name=='Ngly1',1][1],]))

Hoxc11= unname(unlist(ddsed.norm[ids[ids$gene_name=='Hoxc11',1][1],]))

Hoxc10 = unname(unlist(ddsed.norm[ids[ids$gene_name=='Hoxc10',1][1],]))

Hoxc13 = unname(unlist(ddsed.norm[ids[ids$gene_name=='Hoxc13',1][1],]))

Hoxa10 = unname(unlist(ddsed.norm[ids[ids$gene_name=='Hoxa10',1,][1],]))
Hoxc9= unname(unlist(ddsed.norm[ids[ids$gene_name=='Hoxc9',1,][1],]))
Hoxd3 = unname(unlist(ddsed.norm[ids[ids$gene_name=='Hoxd3',1,][1],]))


data = data.frame(sampleAnnot,Ngly1,Hoxa10,Hoxc9,Hoxc10,Hoxc11,Hoxc13,Hoxd3)

write.table(data, quote = F,row.names=F, col.names=T, sep = "\t", file = "NGLY1-Hox-Family-Mouse.txt")






#gene.plot("NGLY1")
#gene.plot("PSMB1")
#gene.plot("PSMD1")
#gene.plot("PSMD11")
#gene.plot("PSMD14")
#gene.plot("PSMC2")


#gene = unname(unlist(ddsed.norm["ENSG00000154277",]))
#data = data.frame(sampleAnnot,gene)

#pdf(file.path(folder, '/5-geneCheck/Human-UCHL1-Normalized-Expression.pdf'))
#lattice::dotplot(gene~individual,data=data,group=sampleStatus, auto.key=T, pch=19, ylab="Gene Expression",xlab="UCHL1") 
#dev.off()
