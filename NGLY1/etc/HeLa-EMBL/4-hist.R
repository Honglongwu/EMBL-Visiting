library(ggplot2)
pdf("HeLa-protein-peptide-distribution.pdf")
df = read.table('Homo_sapiens.GRCh37.70.pep.all-peptides-num')
colnames(df) = c('protein','number')
df = df[df$number > 0,]
ggplot(df, aes(x=number)) + geom_histogram(breaks=c(1:50), colour="black", fill="white") + xlab("Number of peptides belong to each protein") + ylab('Number of proteins')
dev.off()


