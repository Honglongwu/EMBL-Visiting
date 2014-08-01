#deseq_three_sets=read.table('DE_ngly1_threesets_genes.txt',header=F)
#deseq_three_sets_gene=unique(deseq_three_sets[,2])

#deseq_two_sets=read.table('DE_ngly1_twosets_genes.txt',header=F)
#deseq_two_sets_gene=unique(deseq_two_sets[,2])



upf=read.table('../UPF1-regulated.txt',sep='\t',header=T)
upf_gene=unique(unlist(lapply(as.character(upf$Gene.names[upf$Average.log2.fold.siUpf1.control>0]),strsplit,';')))
upf_gene = upf_gene[!grepl('\\s',upf_gene)]

sig_gene = function(inFile)
{
read.table('DE_CP1.sig_gene.txt',header=F)[1]
}

inFiles = c('DE_CP1.sig_gene.txt','DE_CP2.sig_gene.txt','DE_CP3.sig_gene.txt','DE_CP4.sig_gene.txt')
sig_gene_four_patient=lapply(inFiles, sig_gene)



#intersect(deseq_three_sets_gene, upf_gene)
#intersect(deseq_two_sets_gene, upf_gene)




