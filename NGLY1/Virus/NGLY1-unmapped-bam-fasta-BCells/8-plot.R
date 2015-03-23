library(ggplot2)
gg_color_hue <- function(n) {
      hues = seq(15, 375, length=n+1)
  hcl(h=hues, l=65, c=100)[1:n]
}
rt =read.table('NGLY1-Viruses-samples2')
colnames(rt) = c('Sample','Count')
#qplot(x=ordered(as.factor(Sample),c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), y='Reads Count', data=rt, geom="bar", stat="identity",position="dodge", fill="white",colour="darkgreen")
#qplot(x=Sample, y=Count, data=rt, geom="bar", stat="identity",position="dodge")
pdf("NGLY1-Virus-B-Cells.pdf")
c <- ggplot(rt, aes(x=factor(Sample, levels=c('CP1-B','CP3-B','MCP1-B','Ctrl-B')),y=Count))
c + geom_bar(stat="identity", width=0.7, fill=gg_color_hue(2)[1], colour=gg_color_hue(2)[1]) + ylab("Number of reads from human herpesvirus 4 (EBV)") + xlab("Sample of B cells")
dev.off()
