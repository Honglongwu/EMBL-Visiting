x1=read.table('Table1-all-png1-interactions-from-sgd-genetic_physical-human-homologs.txt',sep='\t')
x1 = unique(x1[,2])


x2=read.table('Table2-human-orthologs-of-mouse-monarch-hits.txt',sep='\t')
x2 = unique(x2[,2])

x3=read.table('Table3-human_genes-ngly1-interactors-from-monarch_biogrid.txt',sep='\t')
x3 = unique(x3[,2])

x4=read.table('Table4-human-orthologs-of-yeast-genes-with-shared-png1-phenos-in-sgd.txt',sep='\t')
x4 = unique(x4[,2])

x=Reduce(union,list(x1,x2,x3,x4))
write.table(x,'human-ngly1-interaction-gene.txt',quote=F,row.names=F,col.names=F)
