library(ggplot2)
gg_color_hue <- function(n) {
      hues = seq(15, 375, length=n+1)
  hcl(h=hues, l=65, c=100)[1:n]
}
rt =read.table('5-wrong-map-mouse-to-human2.formated')
data = rt[,c(1,3)]
colnames(data) = c('Sample','Percentage')
#qplot(x=ordered(as.factor(Sample),c('CP1-B','CP3-B','MCP1-B','Ctrl-B')), y='Reads Count', data=rt, geom="bar", stat="identity",position="dodge", fill="white",colour="darkgreen")
#qplot(x=Sample, y=Count, data=rt, geom="bar", stat="identity",position="dodge")
pdf("NGLY1-Mapping-Percentage.pdf")
c <- ggplot(data, aes(x=factor(Sample),y=Percentage))
c + geom_bar(stat="identity", width=0.7, fill=gg_color_hue(2)[1], colour=gg_color_hue(2)[1]) + ylab("Percentage of reads mapped") + xlab("Samples")
dev.off()
