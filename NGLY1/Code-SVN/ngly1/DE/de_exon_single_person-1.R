# test difference at exon level
# Author: czhu
###############################################################################
library(DEXSeq)
ncpu=10
#gene = "NGLY1"
gene = commandArgs(trailingOnly=TRUE)[1]

gene

folder = "/g/steinmetz/wmueller/NGLY1/"
load(file.path(folder, "exon-CP4/exonCounts-CP4.rda"))
load(file.path(folder, "sampleAnnot-CP4.rda"))
outfolder = file.path(folder, "exon-CP4")
if (!file.exists(outfolder))  dir.create(outfolder)

## first look at gene counts
mat = assay(exonCounts)

#hanice#
geneInteraction = function(genename)
{
DIR = '/g/steinmetz/hsun/NGLY1/Data/string'
inFile = paste0(file.path(DIR,genename),'-partners')
if(file.exists(inFile))
{
gene = read.table(inFile)
return(gene[,1])
}
}

## exclude sample 19 for the time being
for(thisIndividual in levels(sampleAnnot$individual)){
    wh = sampleAnnot$individual == thisIndividual 
    
    submat = mat[, wh]
    subSampleAnnot = droplevels(sampleAnnot[wh, ])
    
    selGene = unique(as.character(exonicParts$gene_id))
    sel = as.logical(mcols(exonicParts)$gene_id %in% selGene)
    mygenes = exonicParts[sel]
    submat = submat[sel,]
    
    dxd = DEXSeqDataSet(submat, subSampleAnnot,
        design= ~ treatment + exon+treatment:exon,
        featureID=as.character(mcols(mygenes)$exonic_part), 
        groupID=as.character(mcols(mygenes)$gene_id),
        featureRanges=mygenes
#transcripts=as.character(mcols(mygenes)$tx_name)  
    )
    
    dxd = DEXSeq::estimateSizeFactors( dxd )
    dxd = DEXSeq::estimateDispersions( dxd , BPPARAM=MulticoreParam(workers=ncpu))
    dxd = testForDEU( dxd, reducedModel=~ treatment + exon,   BPPARAM=MulticoreParam(workers=ncpu))
    dxd = estimateExonFoldChanges( dxd, fitExpToVar="treatment", BPPARAM=MulticoreParam(workers=ncpu))
    dxr1 = DEXSeqResults( dxd )
    save(dxd, dxr1, file=file.path(outfolder, paste0("DE_", thisIndividual, ".rda")))
    
#plotDispEsts( dxd )
    
    plotFolder = file.path(outfolder, "plot")
    if (!file.exists(plotFolder))  dir.create(plotFolder)
    genes = geneInteraction(gene)
    pdf(file.path(plotFolder, paste0(thisIndividual,"_",gene,".pdf")), width=12, height=8)
    for(thisExon in genes){
        plotDEXSeq( dxr1, thisExon, legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 ,displayTranscripts=TRUE, 
            fitExpToVar="treatment",norCounts=TRUE, splicing=TRUE)
    }
    dev.off()    
}
