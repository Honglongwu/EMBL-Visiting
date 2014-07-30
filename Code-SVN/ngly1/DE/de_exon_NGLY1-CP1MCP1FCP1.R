# test difference at exon level for all data
# Author: czhu
###############################################################################
library(DEXSeq)

folder = "/g/steinmetz/wmueller/NGLY1"
outfolder = file.path(folder, "exon-CP4")

load(file.path(outfolder, "exonCounts-CP4.rda"))
load(file.path(folder, "sampleAnnot-CP4.rda"))

## first look at gene counts
mat = assay(exonCounts)
## use all samples
#wh = rep(TRUE, ncol(mat))
wh = which(grepl("[MF]?CP1", sampleAnnot$individual) & sampleAnnot$treatment == "DMSO" )
#wh = sampleAnnot$individual == "19"
mat = mat[, wh]
sampleAnnot = droplevels(sampleAnnot[wh, ])
selGene = unique(as.character(exonicParts$gene_id))
sel = as.logical(mcols(exonicParts)$gene_id %in% selGene)
mygenes = exonicParts[sel]
mat = mat[sel,]
#sampleAnnot$sample = factor(sampleAnnot$label)


dxd = DEXSeqDataSet(mat, sampleAnnot,
    design= ~ individual +exon+ sampleStatus:exon + biorep:exon,
    featureID=as.character(mcols(mygenes)$exonic_part), 
    groupID=as.character(mcols(mygenes)$gene_id),
    featureRanges=mygenes
#transcripts=as.character(mcols(mygenes)$tx_name)  
)

ncpu=10
dxd = DEXSeq::estimateSizeFactors( dxd )
dxd = DEXSeq::estimateDispersions( dxd , BPPARAM=MulticoreParam(workers=ncpu))
dxd = testForDEU( dxd, reducedModel = ~ individual +exon+ biorep:exon,BPPARAM= MulticoreParam(workers=ncpu))
dxd = estimateExonFoldChanges( dxd,fitExpToVar="sampleStatus", BPPARAM=MulticoreParam(workers=ncpu))
dxr1 = DEXSeqResults( dxd )
save(dxd, dxr1, file=file.path(outfolder, "DE_NGLY1_DMSO-CP1MCP1FCP1.rda"))


#plotFolder=file.path(outfolder, "plot")
#if (!file.exists(plotFolder))  dir.create(plotFolder)
#
#pdf(file.path(plotFolder, "DE_all_SRSF.pdf"), width=12, height=8)
#for(thisExon in paste0("SRSF",1:12)){
#    plotDEXSeq( dxr1, thisExon, legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 ,displayTranscripts=TRUE, 
#        fitExpToVar="treatment",norCounts=TRUE, splicing=TRUE)
#}
#dev.off()





