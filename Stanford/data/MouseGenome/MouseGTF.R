library(rtracklayer)
gtf=import.gff('Mus_musculus.GRCm38.73.gtf', format='gtf')
ids=mcols(gtf)[c("gene_id","gene_name","gene_biotype")]
ids=as.data.frame(ids)
save(gtf,ids,file='MouseGTF.rda')
