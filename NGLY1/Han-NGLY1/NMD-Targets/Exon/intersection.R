#deseq_three_sets=read.table('DE_ngly1_threesets_genes.txt',header=F)
#deseq_three_sets_gene=unique(deseq_three_sets[,2])

#deseq_two_sets=read.table('DE_ngly1_twosets_genes.txt',header=F)
#deseq_two_sets_gene=unique(deseq_two_sets[,2])


load('/g/steinmetz/wmueller/NGLY1/gtf.rda')
upf=read.table('../UPF1-regulated.txt',sep='\t',header=T)
upf_gene=unique(unlist(lapply(as.character(upf$Gene.names[upf$Average.log2.fold.siUpf1.control>0]),strsplit,';')))
upf_gene = upf_gene[!grepl('\\s',upf_gene)]

sig_gene = function(inFile)
{
read.table(inFile,header=F)[,1]
}

inFiles = c('DE_CP1.sig_gene.txt','DE_CP2.sig_gene.txt','DE_CP3.sig_gene.txt','DE_CP4.sig_gene.txt')
sig_gene_four_patient=lapply(inFiles, sig_gene)
sig_gene_four=Reduce(intersect,sig_gene_four_patient)
sig_gene_four_id = ids[ids$gene_name %in% sig_gene_four,c('gene_id','gene_name')]
write.table(sig_gene_four, 'de_exon_CP1_CP2_CP3_CP4_sig_genes.txt',col.names=F,row.names=F,quote=F)
write.table(sig_gene_four_id, 'de_exon_CP1_CP2_CP3_CP4_sig_genes_id.txt',col.names=F,row.names=F,quote=F)
intersect(upf_gene, sig_gene_four)

inFiles = c('DE_CP1.sig_gene.txt','DE_CP2.sig_gene.txt','DE_CP3.sig_gene.txt',
            'DE_CP4.sig_gene.txt','DE_MCP1.sig_gene.txt',
            'DE_19.sig_gene.txt')
sig_gene_all_sample=lapply(inFiles, sig_gene)
sig_all=as.matrix(table(unlist(sig_gene_all_sample)))
sig_all_gene_mul=rownames(sig_all)[sig_all[,1]>0]
upf_sig=intersect(upf_gene, sig_all_gene_mul)
upf_sig_id = ids[ids$gene_name %in% upf_sig,c('gene_id','gene_name')]
write.table(upf_sig,'de_exon_upf_sig_genes.txt',col.names=F,row.names=F, quote=F)
write.table(upf_sig_id,'de_exon_upf_sig_genes_id.txt',col.names=F,row.names=F, quote=F)




#intersect(deseq_three_sets_gene, upf_gene)
#intersect(deseq_two_sets_gene, upf_gene)




