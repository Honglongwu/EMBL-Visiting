#rt = read.table("UCEC__unc.edu__illuminaga_rnaseqv2__rsem.genes.results__Jul-08-2014.txt", sep="\t")
rt = read.table("test", sep="\t")
select.y=seq(3,dim(rt)[2],2)
select.x=seq(3,dim(rt)[1],1)
rt.select = rt[select.x,select.y]
rownames(rt.select) = rt[select.x,1]
colnames(rt.select) = unlist(rt[1,select.y])

#rt2 = read.table("UCEC__unc.edu__illuminahiseq_rnaseqv2__rsem.genes.results__Jul-08-2014.txt", sep = "\t")
rt2 = read.table("test2", sep = "\t")
select.y=seq(3,dim(rt2)[2],2)
select.x=seq(3,dim(rt2)[1],1)
rt2.select = rt2[select.x,select.y]
rownames(rt2.select) = rt2[select.x,1]
colnames(rt2.select) = unlist(rt2[1,select.y])

sample = c(colnames(rt.select),colnames(rt2.select))
platform = rep(c("ga", "hiseq"), times=c(length(colnames(rt.select)),length(colnames(rt2.select))))
tumor = rep("UCEC", each=length(sample))
annotation = data.frame(sample=sample,platform=platform,tumor=tumor)
merge(rt.select, rt2.select, by.x=0,by.y=0,)

