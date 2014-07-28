folder = "/g/steinmetz/wmueller/NGLY1/"
load(file.path(folder,'drug_effect-CP4','DESeq-treatment-control-pairwise.rda'))
pwlist=de.pw.indi.list
sigfunc=function(x)
{
    rownames(x[x$padj<0.01,])
}
pwsig=lapply(pwlist,sigfunc)
six_samples=Reduce(intersect, pwsig)
four_patients=Reduce(intersect, pwsig[1:4])
load('/g/steinmetz/wmueller/NGLY1/gtf.rda')
genes = ids[ids$gene_id %in% six_samples,]
write.table(genes,'DE_treatment_six_samples.txt',quote=F,row.names=F, col.names=F)
write.table(genes[1],'DE_treatment_six_samples_id.txt',quote=F,row.names=F, col.names=F)
write.table(genes[2],'DE_treatment_six_samples_symbol.txt',quote=F,row.names=F, col.names=F)
genes2 = ids[ids$gene_id %in% four_patients,]
write.table(genes2,'DE_treatment_four_patients.txt',quote=F,row.names=F, col.names=F)
write.table(genes2[1],'DE_treatment_four_patients_id.txt',quote=F,row.names=F, col.names=F)
write.table(genes2[2],'DE_treatment_four_patients_symbol.txt',quote=F,row.names=F, col.names=F)

sigfunc2=function(x)
{
    if(unique(x$indi) %in% paste0('CP',1:4))
    {
    rownames(x[x$padj<0.01,])
    }else
    {
    rownames(x[x$padj>0.01,])
    }
}
pwsig=lapply(pwlist,sigfunc2)
six_samples=Reduce(intersect, pwsig)
genes3 = ids[ids$gene_id %in% six_samples,]
write.table(genes3,'DE_treatment_four_patients_two_parents.txt',quote=F,row.names=F, col.names=F)
write.table(genes3[1],'DE_treatment_four_patients_two_parents_id.txt',quote=F,row.names=F, col.names=F)
write.table(genes3[2],'DE_treatment_four_patients_two_parents_symbol.txt',quote=F,row.names=F, col.names=F)
