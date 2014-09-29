library(ggplot2)
rt =read.table('NGLY1-Viruses-samples2')
colnames(rt) = c('Sample','Reads Count')
qplot(x=ordered(as.factor(sample),c()), y=count, data=rt, geom="bar", stat="identity",position="dodge", fill="white",colour="darkgreen")
