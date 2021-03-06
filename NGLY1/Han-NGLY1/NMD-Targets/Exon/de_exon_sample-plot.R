# test difference at exon level for all data
# Author: czhu
###############################################################################
library(DEXSeq)

folder = "/g/steinmetz/wmueller/NGLY1"
outfolder = file.path(folder, "exon-CP4")

load(file.path(outfolder, "DE_CP4.rda"))

sigplot=function(gene,filename){
    print(filename)
plotFolder=file.path("plot")
if (!file.exists(plotFolder))  dir.create(plotFolder)

pdf(file.path(plotFolder, filename), width=12, height=8)
for(thisExon in gene){
    plotDEXSeq( dxr1, thisExon, legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 ,displayTranscripts=TRUE, 
        fitExpToVar="treatment",norCounts=TRUE, splicing=TRUE)
}
dev.off()
}

#genes=c('SMG7','DDIT4','ABHD4','GABARAPL1','STC2','ATF3','TNFRSF10B','CTGF','RCAN1','GPT2','AIFM2','SLC7A11','PLIN3','ASNS','SLC3A2','GRAMD3','CA12','GRB10','LMNB2','LDLR','SARS')
#sigplot(genes, filename = paste0("DE_all_",paste(genes[1:3],collapse='_'),'_etc.pdf'))
#genes=c('RPP25','TGIF1','GNPDA1','MRPL49','PDRG1','GATAD1','SKP2','ALAS1','HIST1H1D','H1FX','C8orf33','HSPB1')
genes=c('RPP25','TGIF1','GNPDA1','MRPL49','PDRG1','GATAD1')#,'SKP2','ALAS1','HIST1H1D','H1FX','C8orf33','HSPB1')
genes=c('SKP2')
genes=c('C10orf76','RCAN1','RAB3GAP1','RRN3','SLC3A2','LEMD2','SAMM50','DUSP3','UBAC2','TXNDC12')
genes=c('SLC3A2')
genes=c('SLC7A11')
#genes = read.table('DE_CP1.sig_gene.txt',header=F)[,1]
genes = c('RCAN1','SLC3A2')
sigplot(genes, filename = paste0("DE_single_",paste(genes[1:3],collapse='_'),'_etc.pdf'))
#sigplot(c('C5orf45','EIF3I','ENOSF1','LRRFIP1','RGS3','SQSTM1'))
