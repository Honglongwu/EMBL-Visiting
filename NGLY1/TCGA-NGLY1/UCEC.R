rt = read.table("UCEC__unc.edu__illuminaga_rnaseqv2__rsem.genes.results__Jul-08-2014.txt", sep="\t")
select.y=seq(3,dim(rt)[2],2)
select.x=seq(3,dim(rt)[1])
rt.select = rt[select.x,select.y]
rownames(rt.select) = rt[select.x,1]
colnames(rt.select) = unlist(rt[1,select.y])
