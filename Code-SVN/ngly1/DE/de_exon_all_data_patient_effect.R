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
wh = rep(TRUE, ncol(mat))
#wh = sampleAnnot$individual == "19"
mat = mat[, wh]
sampleAnnot = droplevels(sampleAnnot[wh, ])
selGene = unique(as.character(exonicParts$gene_id))
sel = as.logical(mcols(exonicParts)$gene_id %in% selGene)
mygenes = exonicParts[sel]
mat = mat[sel,]

dxd = DEXSeqDataSet(mat, sampleAnnot,
    design= ~ individual + treatment + sampleStatus+exon+treatment:exon+sampleStatus:exon,
    featureID=as.character(mcols(mygenes)$exonic_part), 
    groupID=as.character(mcols(mygenes)$gene_id),
    featureRanges=mygenes
#transcripts=as.character(mcols(mygenes)$tx_name)  
)

ncpu=20
dxd = DEXSeq::estimateSizeFactors( dxd )
dxd = DEXSeq::estimateDispersions( dxd , BPPARAM=MulticoreParam(workers=ncpu))
dxd = testForDEU( dxd, reducedModel=~ individual + treatment+exon+sampleStatus+sampleStatus:exon,   BPPARAM=MulticoreParam(workers=ncpu))
dxd = estimateExonFoldChanges( dxd, fitExpToVar="treatment", BPPARAM=MulticoreParam(workers=ncpu))
dxr1 = DEXSeqResults( dxd )

save(dxd, dxr1, file=file.path(outfolder, "DE_all_patient_effect.rda"))


