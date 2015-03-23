df = read.table('Foldchange-NGLY1_KOvsWT-Double_KOvsWT',head=T)
pdf('Foldchange-NGLY1_KOvsWT-Double_KOvsWT.pdf')
plot(df$NGLY1_KOvsWT, df$Double_KOvsWT)
abline(lm(df$NGLY1_KOvsWT~df$Double_KOvsWT), col="red")
dev.off()



df = read.table('Foldchange-NGLY1_KOvsWT-NGLY1_KOvsDouble_KO',head=T)
pdf('Foldchange-NGLY1_KOvsWT-NGLY1_KOvsDouble_KO.pdf')
plot(df$NGLY1_KOvsWT, df$NGLY1_KOvsDouble_KO)
abline(lm(df$NGLY1_KOvsWT~df$NGLY1_KOvsDouble_KO), col="red")
dev.off()
