source('Fibroblast-B-Cell-Count.R')
FBE=FB[c(7,9,10),]
write.table(FBE,file='Fibroblast-B-Cell-Expressed',quote=F)

library(ggplot2)
library(reshape2)

melted <- melt(FBE, id.vars=c("Row.names"))
pdf('Fibroblast-B-Cell-Expressed.pdf')
colnames(melted)
ggplot(melted,aes(x=factor(variable, levels=c('CP1','CP2','CP3','CP4','FCP1','MCP1','CP1.B','CP3.B','MCP1.B','Ctrl.B','Ctrl.19')), fill=`Row.names`, y=value)) + geom_bar(stat="identity",position="dodge") + xlab("Sample") +ylab("Number of reads") + theme(axis.text=element_text(size=8))
dev.off()
