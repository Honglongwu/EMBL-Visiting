x=read.table('ENSG00000151092-GRCh37-transcripts-unique-region2-counts-Bcells.txt',head=T, stringsAsFactors=F)
BCell=data.frame(CP1.B=x[,1]+x[,2], CP3.B=x[,3]+x[,4], MCP1.B=x[,7]+x[,8],Ctrl.B=x[,5]+x[,6])
rownames(BCell)=rownames(x)
z=read.table('NGLY1-Isoforms-unique-region-CP1234',head=T, stringsAsFactors=F)
FCell=data.frame(CP1=z[,7]+z[,8],CP2=z[,11]+z[,12],CP3=z[,15]+z[,16],CP4=z[,19]+z[,20],FCP1=z[,23]+z[,24],MCP1=z[,27]+z[,28],Ctrl.19=z[,3]+z[,4])
rownames(FCell)=rownames(x)
FB = merge(FCell, BCell,by.x=0,by.y=0)
rownames(FB)=FB[,1]

FBE=FB[c(7,9,10),]
write.table(FBE,file='Fibroblast-B-Cell-Expressed',quote=F)

library(ggplot2)
library(reshape2)

melted <- melt(FBE, id.vars=c("Row.names"))
pdf('Fibroblast-B-Cell-Expressed.pdf')
colnames(melted) = c('Transcript','variable','value')
melted$Transcript=c('ENST00000489271','ENST00000493324','ENST00000496726')
ggplot(melted,aes(x=factor(variable, levels=c('CP1','CP2','CP3','CP4','FCP1','MCP1','CP1.B','CP3.B','MCP1.B','Ctrl.B','Ctrl.19')), fill=Transcript, y=value))+ geom_bar(stat="identity",position="dodge") + xlab("Sample") +ylab("Number of reads") + theme(axis.text=element_text(size=8))
dev.off()
