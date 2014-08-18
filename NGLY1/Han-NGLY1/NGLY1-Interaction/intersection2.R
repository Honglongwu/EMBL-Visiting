interaction.human <- read.table("human-ngly1-interaction-gene.txt")


two = read.table("DE_ngly1_twosets_genes.txt")
intersect(interaction.human[,1], two[,2])

three= read.table("DE_ngly1_threesets_genes.txt")
intersect(interaction.human[,1], three[,2])

set1 = read.table("deCP1CP4MCP1.txt")
set1.sig = set1[which(set1$padj<0.01),]
intersect(interaction.human[,1], set1.sig[,7])

set1 = read.table("deCP2CP3FCP1.txt")
set1.sig = set1[which(set1$padj<0.01),]
sig=intersect(interaction.human[,1], set1.sig[,7])
sig
#write.table(set1.sig[set1.sig$gene_name %in% sig,],"sig.gene",quote=F,col.names=NA)



set1 = read.table("deCP1MCP1FCP1.txt")
set1.sig = set1[which(set1$padj<0.01),]
intersect(interaction.human[,1], set1.sig[,7])








