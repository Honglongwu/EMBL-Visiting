library(ggplot2)
gg_color_hue <- function(n) {
      hues = seq(15, 375, length=n+1)
  hcl(h=hues, l=65, c=100)[1:n]
}
rt =read.table('5-wrong-map-mouse-to-human2.formated')
data = rt[,c(2,3)]
data=cbind(rownames(data),data)
colnames(data) = c('SampleID','Sample','Number')
data = data[order(data$Number),]
write.table(data, file ='NGLY1-Mapping-Number', quote=F, sep = '\t', row.names =F)

pdf("NGLY1-Mapping-Number.pdf")
c <- ggplot(data, aes(x=factor(SampleID,level = SampleID),y=Number))
#c + geom_bar(stat="identity", width=0.7, fill=gg_color_hue(2)[1], colour=gg_color_hue(2)[1]) + ylab("Percentage of reads mapped") + xlab("Samples")
c + geom_bar(stat="identity", width=0.7)  + ylab("Number of reads") + xlab("Samples")
dev.off()
