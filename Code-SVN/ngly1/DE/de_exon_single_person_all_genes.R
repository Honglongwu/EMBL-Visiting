# test difference at exon level
# Author: czhu
###############################################################################
folder='/g/steinmetz/hsun/NGLY1/NGLY1-wmueller/exon-CP4'

sigget =function(sample){
    load(file.path(folder, sample))
    sig_genes = unique(dxr1$groupID[dxr1$padj<0.01 & !is.na(dxr1$padj)])
    return(sig_genes)
}

sigplot = function(sample,gene){
    load(file.path(folder, sample))
    plotFolder = file.path(folder, "plot")
    if (!file.exists(plotFolder))  dir.create(plotFolder)

    pdf(file.path(plotFolder, paste0(unlist(strsplit(sample, "[.]"))[1],"_exon_sig.pdf")), width=12, height=8)
    for(thisExon in gene){
        plotDEXSeq( dxr1, thisExon, legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 ,displayTranscripts=TRUE, 
            fitExpToVar="treatment",norCounts=TRUE, splicing=TRUE)
    }
    dev.off()   
}
siggenes = lapply(c('DE_CP1.rda', 'DE_CP2.rda', 'DE_CP3.rda', 
               'DE_CP4.rda', 'DE_MCP1.rda', 'DE_FCP1.rda'), sigget)
names(siggenes) = c('CP1', 'CP2', 'CP3', 'CP4', 'MCP1', 'FCP1')
lapply(siggenes,length)
six_samples = Reduce(intersect, siggenes[1:6])
four_patients = Reduce(intersect, siggenes[1:7])
print(six_samples)
print(four_patients)
lapply(c('DE_CP1.rda', 'DE_CP2.rda', 'DE_CP3.rda', 
         'DE_CP4.rda', 'DE_MCP1.rda', 'DE_FCP1.rda'), sigplot,gene=four_patients)
