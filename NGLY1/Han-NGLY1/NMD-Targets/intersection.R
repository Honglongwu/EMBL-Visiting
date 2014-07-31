#deseq_three_sets=read.table('DE_ngly1_threesets_genes.txt',header=F)
#deseq_three_sets_gene=unique(deseq_three_sets[,2])

#deseq_two_sets=read.table('DE_ngly1_twosets_genes.txt',header=F)
#deseq_two_sets_gene=unique(deseq_two_sets[,2])



upf=read.table('UPF1-regulated.txt',sep='\t',header=T)
upf_gene=unique(unlist(lapply(as.character(upf$Gene.names[upf$Average.log2.fold.siUpf1.control>0]),strsplit,';')))
write.table(upf_gene,'test_gene',quote=F)

#intersect(deseq_three_sets_gene, upf_gene)
#intersect(deseq_two_sets_gene, upf_gene)




