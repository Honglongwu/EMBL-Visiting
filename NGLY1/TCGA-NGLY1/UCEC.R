rt = read.table("UCEC__unc.edu__illuminaga_rnaseqv2__rsem.genes.results__Jul-08-2014.txt", sep="\t", stringsAsFactors=F)
#rt = read.table("test", sep="\t", stringsAsFactors=F)
select.y=seq(3,dim(rt)[2],2)
select.x=seq(3,dim(rt)[1],1)
rt.select = rt[select.x,select.y]
rownames(rt.select) = rt[select.x,1]
colnames(rt.select) = unlist(rt[1,select.y])
colnames(rt.select)[colnames(rt.select)=="TCGA-AX-A1C7-01A-11R-A137-07"]="TCGA-AX-A1C7-01A-11R-A137-07.x"
## TCGA-AX-A1C7-01A-11R-A137-07

rt2 = read.table("UCEC__unc.edu__illuminahiseq_rnaseqv2__rsem.genes.results__Jul-08-2014.txt", sep = "\t", stringsAsFactors=F)
#rt2 = read.table("test2", sep = "\t", stringsAsFactors=F)
select.y=seq(3,dim(rt2)[2],2)
select.x=seq(3,dim(rt2)[1],1)
rt2.select = rt2[select.x,select.y]
rownames(rt2.select) = rt2[select.x,1]
colnames(rt2.select) = unlist(rt2[1,select.y])
colnames(rt2.select)[colnames(rt2.select)=="TCGA-AX-A1C7-01A-11R-A137-07"]="TCGA-AX-A1C7-01A-11R-A137-07.y"

sample = c(colnames(rt.select),colnames(rt2.select))
platform = rep(c("ga", "hiseq"), times=c(length(colnames(rt.select)),length(colnames(rt2.select))))
tumor = rep("UCEC", each=length(sample))
#sex = rep("female", each=length(sample))
annotation = data.frame(sample=sample,platform=platform,tumor=tumor)
count = merge(rt.select, rt2.select, by.x=0,by.y=0)
rownames(count)=count[,1]
count=count[,2:dim(count)[2]]
count.numeric = as.data.frame(sapply(count,as.numeric))
rownames(count.numeric) = rownames(count)
count = count.numeric
save.image(file="UCEC.rda")
write.table(annotation$sample,file="UCEC-samples",quote=F,row.names=F,col.names=F)

###phenotype
###using python to prepare input file
phenotype=read.table("UCEC-samples-phenotype",sep="\t")
colnames(phenotype)= c("sample", "gender", "race", "tumor_status","age")
annotation.phenotype=merge(annotation,phenotype,by.x=1,by.y=1)
annotation.phenotype.sorted=annotation.phenotype[match(annotation$sample,annotation.phenotype[,1]),]
annotation = annotation.phenotype.sorted


NGLY1.count=count[grepl('NGLY1',rownames(count)),]
NGLY1.count[,grepl("TCGA-D1-A17Q-01|TCGA-B5-A0JY-01|TCGA-D1-A103-01|TCGA-B5-A11N-01",colnames(NGLY1.count))]
NGLY1.count.t=as.data.frame(t(NGLY1.count))
colnames(NGLY1.count.t) = "reads.number"
NGLY1.count.t.ga = subset(NGLY1.count.t,annotation$platform=="ga")

library(ggplot2)
#pdf('UCEC-NGLY1-ga-count-distribution-bin50.pdf')
#color = rep(c("white", "red", "white", "red", "white"), times=c(5,3,12,1,53))
#ggplot(df, aes(x=count)) + geom_histogram(binwidth=50,colour="black", fill=color) + ylab("Number of Samples") + xlab('NGLY1 Expression (RNA-Seq raw reads count)')
#ggplot(df, aes(x=count)) + geom_histogram(colour="black", fill="white") + ylab("Number of Samples") + xlab('NGLY1 Expression (RNA-Seq raw reads count)')
#dev.off()
ggplot(NGLY1.count.t.ga, aes(x=reads.number)) + geom_histogram(binwidth=50,colour="black", fill="white") + ylab("Number of Samples") + xlab('NGLY1 Expression (RNA-Seq raw reads count)')

###
#count.test = colnames(count)
#count.test[count.test=='TCGA-AX-A1C7-01A-11R-A137-07.y']='TCGA-AX-A1C7-01A-11R-A137-07'
#count.test[count.test=='TCGA-AX-A1C7-01A-11R-A137-07.x']='TCGA-AX-A1C7-01A-11R-A137-07'
#count.test[2:length(count.test)]==sample
###

NGLY1.count[,NGLY1.count.t<=600 & NGLY1.count.t >= 500 & annotation$platform=='ga' & annotation$tumor_status=='TUMOR FREE'
            & annotation$race=='WHITE']
annotation[NGLY1.count.t<=600 & NGLY1.count.t >= 500 & annotation$platform=='ga' & annotation$tumor_status=='TUMOR FREE'
            & annotation$race=='WHITE' & annotation$age <= 70 & annotation$age >= 50,]




