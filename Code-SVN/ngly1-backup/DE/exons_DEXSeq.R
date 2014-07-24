# test difference at exon level
# Author: czhu
###############################################################################
library(DEXSeq)

folder = "/g/steinmetz/wmueller/NGLY1/"
load(file.path(folder, "counts.rda"))
load(file.path(folder, "sampleAnnot.rda"))

## first look at gene counts
mat = assay(exonCounts)
#rownames(mat) = paste(rep(names(exonsByGene),sapply(exonsByGene,length)),sapply(exonsByGene,function(x) values(x)$exon_id), sep="_")

## exclude sample 19 for the time being
wh = sampleAnnot$individual != 19
mat = mat[, wh]
sampleAnnot = droplevels(sampleAnnot[wh, ])

fID = as.character(unlist(sapply(exonsByGene,function(x) values(x)$exon_id)))
gID = rep(names(exonsByGene),sapply(exonsByGene,length))

dxd = DEXSeqDataSet(mat, sampleAnnot,
    design= ~ individual + treatment + treatment:exon,
    featureID=fID, 
    groupID=gID
#,featureRanges=exonsByGene
)


ncpu=20
dxd = DEXSeq::estimateSizeFactors( dxd )
dxd = DEXSeq::estimateDispersions( dxd , BPPARAM=MulticoreParam(workers=ncpu))
dxd = testForDEU( dxd, reducedModel=~individual + treatment,   BPPARAM=MulticoreParam(workers=ncpu))
dxd = estimateExonFoldChanges( dxd, fitExpToVar="treatment", BPPARAM=MulticoreParam(workers=ncpu))
dxr1 = DEXSeqResults( dxd )
plotDispEsts( dxd )

#dds = DESeq(dds, test="LRT", reduce=~treatment)
res = results(dds)
res = res[order(res$padj), ]
plotMA(res, ylim =c(-5,5))

rld = rlog(dds, blind=FALSE)
print(plotPCA(rld, intgroup=c("individual", "sampleStatus")))

