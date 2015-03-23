# test difference at exon level for all data
# Author: czhu
###############################################################################
library(DEXSeq)

folder = "/g/steinmetz/wmueller/NGLY1/exon"

infiles = dir(folder, pattern="DE_",full.names=TRUE)
for(i in 1:length(infiles)) {
    thisFile = infiles[i]
    
    load(thisFile)
    
    plotFolder=file.path(folder, "plot")
    if (!file.exists(plotFolder))  dir.create(plotFolder)
    
    pdf(file.path(plotFolder, paste0(sub("\\..*", "",basename(thisFile)),"_SRSF.pdf")), width=12, height=8)
    for(thisExon in paste0("SRSF",1:12)){
        plotDEXSeq( dxr1, thisExon, legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 ,displayTranscripts=TRUE, 
            fitExpToVar="treatment",norCounts=TRUE, splicing=TRUE)
    }
    dev.off()
}
