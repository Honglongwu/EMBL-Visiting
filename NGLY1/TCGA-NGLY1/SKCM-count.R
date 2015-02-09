rt = read.table('SKCM-NGLY1-hiseq.txt', sep='\t')

####
####    TCGA-EE-A2GR-06
####    TCGA-GN-A266-06
####    TCGA-FW-A3R5-06
####    TCGA-EE-A3JA-06
####
####
rt[grepl('TCGA-EE-A2GR-06', unname(unlist(rt[1,])))]
rt[grepl('TCGA-GN-A266-06', unname(unlist(rt[1,])))]
rt[grepl('TCGA-FW-A3R5-06', unname(unlist(rt[1,])))]
rt[grepl('TCGA-EE-A3JA-06', unname(unlist(rt[1,])))]

select=seq(3,dim(rt)[2],2)
count=unname(unlist(rt[2,select]))
count= as.numeric(as.character(count))
sample=unname(unlist(rt[1,select]))
df = data.frame(sample, count)
save(count,sample,file='SKCM-NGLY1-hiseq.rda')


library(ggplot2)
pdf('SKCM-NGLY1-hiseq-count-distribution-bin50.pdf')
color = rep(c("white", "red", "white", "red", "white", "red", "white","red", "white"), times=c(5,3,12,1,53))
ggplot(df, aes(x=count)) + geom_histogram(binwidth=50,colour="black", fill=color) + ylab("Number of Samples") + xlab('NGLY1 Expression (RNA-Seq reads count)')
#ggplot(df, aes(x=count)) + geom_histogram(colour="black", fill="white") + ylab("Number of Samples") + xlab('NGLY1 Expression (RNA-Seq raw reads count)')
dev.off()

pdf('SKCM-NGLY1-hiseq-count-distribution-bin100.pdf')
##color = rep(c("white", "red", "white", "red", "white"), times=c(3,2,6,1,27))
color = rep(c("white", "red", "white", "red", "white", "red", "white","red", "white"), times=c(5,1,3,1,3,1,3,1,27))
ggplot(df, aes(x=count)) + geom_histogram(binwidth=100,colour="black",fill=color) + ylab("Number of Samples") + xlab('NGLY1 Expression (RNA-Seq reads count)')
ggplot(df, aes(x=count)) + geom_histogram(binwidth=100,colour="black") + ylab("Number of Samples") + xlab('NGLY1 Expression (RNA-Seq reads count)')
dev.off()

pdf('SKCM-NGLY1-hiseq-count-distribution-bin100-2.pdf')
color = rep(c("white", "red", "white","blue", "white"), times=c(3,2,1,1,32))
ggplot(df, aes(x=count)) + geom_histogram(binwidth=100,colour="black",fill=color) + ylab("Number of Samples") + xlab('NGLY1 Expression (RNA-Seq reads count)')
dev.off()

