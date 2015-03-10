library(DESeq2)

load('resNGLY1.rda')
load('/g/steinmetz/hsun/Stanford/data/HumanGTF.rda')
ddsed.norm = counts(dds,norm=T)

NGLY1 = unname(unlist(ddsed.norm[ids[ids$gene_name=='NGLY1',1,],]))

RAD23A = unname(unlist(ddsed.norm[ids[ids$gene_name=='RAD23A',1,],]))

RAD23B = unname(unlist(ddsed.norm[ids[ids$gene_name=='RAD23B',1,],]))

VCP = unname(unlist(ddsed.norm[ids[ids$gene_name=='VCP',1,],]))

UBC = unname(unlist(ddsed.norm[ids[ids$gene_name=='UBC',1,],]))

UCHL1 = unname(unlist(ddsed.norm[ids[ids$gene_name=='UCHL1',1,],]))

data = data.frame(sampleAnnot,NGLY1,RAD23A, UCHL1, RAD23B, VCP, UBC)

write.table(data, quote = F,row.names=F, col.names=T, sep = "\t", file = "NGLY1-RADUBC-Family.txt")

data=data[c(11,12,13,14,1,2,3,4,5,6,7,8,9,10,19,20,21,22,23,24,15,16,17,18,27,28,29,30,25,26),]
data.t=t(data)
write.table(data.t[seq(7,12),],file='Check-Rdata.txt',quote=F,sep='\t',col.names=F)




#gene.plot("NGLY1")
#gene.plot("RAD23A")
#gene.plot("RAD23B")
#gene.plot("VCP")
#gene.plot("UBC")
#gene.plot("UCHL1")


#gene = unname(unlist(ddsed.norm["ENSG00000154277",]))
#data = data.frame(sampleAnnot,gene)

#pdf(file.path(folder, '/5-geneCheck/Human-UCHL1-Normalized-Expression.pdf'))
#lattice::dotplot(gene~individual,data=data,group=sampleStatus, auto.key=T, pch=19, ylab="Gene Expression",xlab="UCHL1") 
#dev.off()
