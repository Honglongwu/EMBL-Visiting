library(DESeq2)

load('res_NGLY1-KO_WT.rda')
load('/g/steinmetz/hsun/Stanford/data/MouseGenome/MouseGTF.rda')
ddsed.norm = counts(dds,norm=T)

NGLY1 = unname(unlist(ddsed.norm[ids[ids$gene_name=='NGLY1',1,],]))

PSMB1 = unname(unlist(ddsed.norm[ids[ids$gene_name=='PSMB1',1,],]))

PSMD1 = unname(unlist(ddsed.norm[ids[ids$gene_name=='PSMD1',1,],]))

PSMD11 = unname(unlist(ddsed.norm[ids[ids$gene_name=='PSMD11',1,],]))

PSMD14 = unname(unlist(ddsed.norm[ids[ids$gene_name=='PSMD14',1,],]))

PSMC2 = unname(unlist(ddsed.norm[ids[ids$gene_name=='PSMC2',1,],]))

data = data.frame(sampleAnnot,NGLY1,PSMB1, PSMC2, PSMD1, PSMD11, PSMD14)

write.table(data, quote = F,row.names=F, col.names=T, sep = "\t", file = "NGLY1-PSM-Family.txt")






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
