no.col <- max(count.fields("NGLY1-BioGrid-Human"))
interaction.human <- read.table("NGLY1-BioGrid-Human",fill=TRUE,col.names=1:no.col)

two = read.table("DE_ngly1_twosets_genes.txt")
intersect(interaction.human[,1], two[,2])



