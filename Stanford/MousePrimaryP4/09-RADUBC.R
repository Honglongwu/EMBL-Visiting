library(DESeq2)

load('res_NGLY1-KO_WT.rda')
load('/g/steinmetz/hsun/Stanford/data/MouseGenome/MouseGTF.rda')
ddsed.norm = counts(dds,norm=T)

Ngly1 = unname(unlist(ddsed.norm[ids[ids$gene_name=='Ngly1',1][1],]))

Vcp = unname(unlist(ddsed.norm[ids[ids$gene_name=='Vcp',1][1],]))

Ubc = unname(unlist(ddsed.norm[ids[ids$gene_name=='Ubc',1][1],]))

Rad23a = unname(unlist(ddsed.norm[ids[ids$gene_name=='Rad23a',1][1],]))

Rad23b = unname(unlist(ddsed.norm[ids[ids$gene_name=='Rad23b',1,][1],]))

Uchl1 = unname(unlist(ddsed.norm[ids[ids$gene_name=='Uchl1',1,][1],]))


data = data.frame(sampleAnnot,Ngly1,Vcp, Ubc, Rad23a, Rad23b,Uchl1)

write.table(data, quote = F,row.names=F, col.names=T, sep = "\t", file = "NGLY1-RADUBC-Family-Mouse.txt")






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
