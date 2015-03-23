# test difference at exon level for all data
# Author: czhu
###############################################################################
library(DEXSeq)

folder = "/g/steinmetz/wmueller/NGLY1"
outfolder = file.path(folder, "exon-CP4")

load(file.path(outfolder, "DE_NGLY1_DMSO-CP2CP3FCP1.rda"))

sigplot=function(gene){
plotFolder=file.path(outfolder, "plot")
if (!file.exists(plotFolder))  dir.create(plotFolder)

pdf(file.path(plotFolder, paste0("DE_all_NGLY1_DMSO-CP2CP3FCP1",paste(gene[1:3],collapse='_'),".pdf")), width=12, height=8)
for(thisExon in gene){
    plotDEXSeq( dxr1, thisExon, legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 ,displayTranscripts=TRUE, 
        fitExpToVar="individual",norCounts=TRUE, splicing=TRUE)
}
dev.off()
}

sigplot(c('BUB1','TP53','NGLY1'))
