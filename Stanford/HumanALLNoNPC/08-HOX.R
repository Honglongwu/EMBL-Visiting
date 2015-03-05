library(DESeq2)

load('resNGLY1.rda')
load('/g/steinmetz/hsun/Stanford/data/HumanGTF.rda')
ddsed.norm = counts(dds,norm=T)

NGLY1 = unname(unlist(ddsed.norm[ids[ids$gene_name=='NGLY1',1,],]))

HOXB3 = unname(unlist(ddsed.norm[ids[ids$gene_name=='HOXB3',1,],]))

HOXB4 = unname(unlist(ddsed.norm[ids[ids$gene_name=='HOXB4',1,],]))

HOXB8 = unname(unlist(ddsed.norm[ids[ids$gene_name=='HOXB8',1,],]))

HOXC5 = unname(unlist(ddsed.norm[ids[ids$gene_name=='HOXC5',1,],]))


data = data.frame(sampleAnnot,NGLY1,HOXB3, HOXB4, HOXB8, HOXC5)

write.table(data, quote = F,row.names=F, col.names=T, sep = "\t", file = "NGLY1-HOX-Family.txt")

data=data[c(11,12,13,14,1,2,3,4,5,6,7,8,9,10,19,20,21,22,23,24,15,16,17,18,27,28,29,30,25,26),]
data.t=t(data)
write.table(data.t[seq(7,11),],file='Check-Rdata.txt',quote=F,sep='\t',col.names=F)




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
