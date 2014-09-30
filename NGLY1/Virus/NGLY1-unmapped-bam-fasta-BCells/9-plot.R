library(ggplot2)
gg_color_hue <- function(n) {
      hues = seq(15, 375, length=n+1)
  hcl(h=hues, l=65, c=100)[1:n]
}
rt =read.table('NGLY1-Viruses-samples2')
colnames(rt) = c('Sample','Count')
Virus = rep('human herpesvirus 4 (EBV)',times=dim(rt)[1])
data=cbind(rt,Virus)
#qplot(x=ordered(as.factor(Sample),c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), y='Reads Count', data=rt, geom="bar", stat="identity",position="dodge", fill="white",colour="darkgreen")
#qplot(x=Sample, y=Count, data=rt, geom="bar", stat="identity",position="dodge")
pdf("NGLY1-Virus-B-Cells.pdf")
qplot(x=factor(Sample, levels=c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), y=Count, fill=`Virus`,data=data,geom="bar",stat="identity",position="dodge",xlab="Sample of B cells", ylab="Number of reads", width=0.7) 
dev.off()
