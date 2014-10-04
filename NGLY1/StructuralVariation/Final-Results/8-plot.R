library(ggplot2)
gg_color_hue <- function(n) {
      hues = seq(15, 375, length=n+1)
  hcl(h=hues, l=65, c=100)[1:n]
}
rt =read.table('NGLY1-SV-num', sep='\t',head=T)
#qplot(x=ordered(as.factor(Sample),c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), y='Reads Count', data=rt, geom="bar", stat="identity",position="dodge", fill="white",colour="darkgreen")
#qplot(x=Sample, y=Count, data=rt, geom="bar", stat="identity",position="dodge")
pdf("NGLY1-SV-Number.pdf")
c <- ggplot(rt, aes(x=factor(Reads, levels=c('2','3','4','More than 4')),y=Count))
c + geom_bar(stat="identity", width=0.7, fill=gg_color_hue(2)[1], colour=gg_color_hue(2)[1]) + ylab("Number of events") + xlab("Number of unique reads")
dev.off()
