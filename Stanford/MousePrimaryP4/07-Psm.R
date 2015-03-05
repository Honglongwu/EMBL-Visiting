library(DESeq2)

load('res_NGLY1-KO_WT.rda')
load('/g/steinmetz/hsun/Stanford/data/MouseGenome/MouseGTF.rda')
ddsed.norm = counts(dds,norm=T)

Ngly1 = unname(unlist(ddsed.norm[ids[ids$gene_name=='Ngly1',1][1],]))

Psma1 = unname(unlist(ddsed.norm[ids[ids$gene_name=='Psma1',1][1],]))

Psmb1 = unname(unlist(ddsed.norm[ids[ids$gene_name=='Psmb1',1][1],]))

Psmc2 = unname(unlist(ddsed.norm[ids[ids$gene_name=='Psmc2',1][1],]))

Psmd1 = unname(unlist(ddsed.norm[ids[ids$gene_name=='Psmd1',1,][1],]))


data = data.frame(sampleAnnot,Ngly1,Psma1, Psmb1, Psmc2, Psmd1)

write.table(data, quote = F,row.names=F, col.names=T, sep = "\t", file = "NGLY1-PSM-Family-Mouse.txt")






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
