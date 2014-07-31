#deseq_three_sets=read.table('DE_ngly1_threesets_genes.txt',header=F)
#deseq_three_sets_gene=unique(deseq_three_sets[,2])

#deseq_two_sets=read.table('DE_ngly1_twosets_genes.txt',header=F)
#deseq_two_sets_gene=unique(deseq_two_sets[,2])



upf=read.table('UPF1-regulated.txt',sep='\t',header=T)
upf_gene=unique(unlist(lapply(as.character(upf$Gene.names[upf$Average.log2.fold.siUpf1.control>0]),strsplit,';')))
upf_gene = upf_gene[!grepl('\\s',upf_gene)]
#write.table(upf_gene,'test_gene',quote=F)

drug_effect_six_samples = read.table('DE_treatment_six_samples.txt', header=F)
drug_effect_six_samples_genes = unique(drug_effect_six_samples[,2])
upf_drug_six = intersect(upf_gene, drug_effect_six_samples_genes)
write.table(upf_drug_six,'upf_drug_effect_six_samples.txt',quote=F,col.names=F, row.names=F)

drug_effect_four_patients = read.table('DE_treatment_four_patients.txt', header=F)
drug_effect_four_patients_genes = unique(drug_effect_four_patients[,2])
upf_drug_four = intersect(upf_gene, drug_effect_four_patients_genes)
write.table(upf_drug_four,'upf_drug_effect_four_patients.txt',quote=F,col.names=F, row.names=F)

drug_effect_four_patients_two_parents = read.table('DE_treatment_four_patients_two_parents.txt', header=F)
drug_effect_four_patients_two_parents_genes = unique(drug_effect_four_patients_two_parents[,2])
upf_drug_four_two = intersect(upf_gene, drug_effect_four_patients_two_parents_genes)
write.table(upf_drug_four_two,'upf_drug_effect_four_patients_two_parents.txt',quote=F,col.names=F, row.names=F)




#intersect(deseq_three_sets_gene, upf_gene)
#intersect(deseq_two_sets_gene, upf_gene)




