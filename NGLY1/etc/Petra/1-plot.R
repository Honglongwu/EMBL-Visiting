library(ggplot2)
library(reshape2)
rt =read.table('CDx-reads-count.curated')
data=cbind(CD=c("CD40","CD21"),rt)
melted <- melt(data, id.vars=c("CD"))
colnames(melted)=c("CD Protein","Sample","value")
pdf('CDx-in-Bcells.pdf')
#qplot(x=factor(Sample, levels=c('CP1_rep1','CP1_rep2','CP3_rep1','CP3_rep2','MCP1_rep1','MCP1_rep2','Ctrl_rep1','Ctrl_rep2')), y=value, fill=`CD Protein`,data=melted, geom="bar", stat="identity",position="dodge",xlab="Sample of B cells", ylab="Number of reads")
ggplot(melted,aes(x=factor(Sample, levels=c('CP1_rep1','CP1_rep2','CP3_rep1','CP3_rep2','MCP1_rep1','MCP1_rep2','Ctrl_rep1','Ctrl_rep2')), fill=`CD Protein`, y=value)) + geom_bar(stat="identity",position="dodge") + xlab("Sample of B cells") +ylab("Number of reads") + theme(axis.text=element_text(size=8))
dev.off()

                                                    
