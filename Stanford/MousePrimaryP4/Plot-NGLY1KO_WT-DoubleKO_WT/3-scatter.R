df = read.table('NGLY1-KO_WT_Double-KO_WT_foldchange')
plot(df$V2, df$V3)
abline(lm(df$V2~df$V3), col="red")
