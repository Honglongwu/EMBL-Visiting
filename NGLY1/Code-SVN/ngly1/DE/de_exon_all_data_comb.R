# test difference at exon level for all data
# including exon from NMD target
# Author: czhu
###############################################################################
library(DEXSeq)

folder = "/g/steinmetz/wmueller/NGLY1/"
outfolder = file.path(folder, "exon_comb")

load(file.path(outfolder, "exonCounts.rda"))
load(file.path(folder, "sampleAnnot.rda"))

## first look at gene counts
mat = assay(exonCounts)
## use all samples
wh = rep(TRUE, ncol(mat))
#wh = sampleAnnot$individual == "19"
mat = mat[, wh]
sampleAnnot = droplevels(sampleAnnot[wh, ])
selGene = unique(as.character(exonicParts$gene_id))
sel = as.logical(mcols(exonicParts)$gene_id %in% selGene)
mygenes = exonicParts[sel]
mat = mat[sel,]

dxd = DEXSeqDataSet(mat, sampleAnnot,
    design= ~ individual + treatment+exon+treatment:exon,
    featureID=as.character(mcols(mygenes)$exonic_part), 
    groupID=as.character(mcols(mygenes)$gene_id),
    featureRanges=mygenes
#transcripts=as.character(mcols(mygenes)$tx_name)  
)

ncpu=20
dxd = DEXSeq::estimateSizeFactors( dxd )
dxd = DEXSeq::estimateDispersions( dxd , BPPARAM=MulticoreParam(workers=ncpu))
dxd = testForDEU( dxd, reducedModel=~ individual + treatment+exon,   BPPARAM=MulticoreParam(workers=ncpu))
dxd = estimateExonFoldChanges( dxd, fitExpToVar="treatment", BPPARAM=MulticoreParam(workers=ncpu))
dxr1 = DEXSeqResults( dxd )
#dxr1 = dxr1[order(dxr1$padj),]

plotFolder=file.path(outfolder, "plot")
if (!file.exists(plotFolder))  dir.create(plotFolder)
#pdf(file.path(plotFolder, "diag.pdf"), width=8, height=6)
#plotDispEsts( dxd )
#plotMA(dxr1)
#dev.off()

save(dxd, dxr1, file=file.path(outfolder, "DE_all.rda"))

table(dxr1[exonicParts$nmd,"padj"] <0.1)

pdf(file.path(plotFolder, "DE_all_nmd.pdf"), width=12, height=8)
for(thisExon in unique(dxr1[exonicParts$nmd, "groupID"])){
    plotDEXSeq( dxr1, thisExon, legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 ,displayTranscripts=TRUE, 
        fitExpToVar="treatment",norCounts=TRUE, splicing=TRUE)
}
dev.off()
