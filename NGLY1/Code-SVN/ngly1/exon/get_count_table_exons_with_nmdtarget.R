# getting exon counts, first merge overlapping exons 
# Author: czhu
###############################################################################
library( "GenomicAlignments" )
library( "Rsamtools" )
library( "GenomicFeatures" )
library(BiocParallel)
register(MulticoreParam(workers = 20))

folder = "/g/steinmetz/wmueller/NGLY1"

outfolder = file.path(folder, "exon")
if (!file.exists(outfolder))  dir.create(outfolder)

hsa=loadDb(file=file.path(folder, "genome/refGene.sqlite"))

exonicParts = disjointExons( hsa, aggregateGenes=FALSE )
seqlevels(exonicParts) =sub("chr", "", seqlevels(exonicParts)) 

## add NMD target, salad code
load(file.path(folder, "misc/nmdTarget.rda"))
nmdGR$addidx =  unlist(tapply(nmdGR$gene,factor(nmdGR$gene, unique(nmdGR$gene)), function(x) { 1:length(x)}))

addGR =  nmdGR
mcols(addGR) = NULL
addGR$gene_id = CharacterList(as.list(nmdGR$gene))
addGR$tx_name = CharacterList(lapply(1:length(nmdGR), function(i){
        exonicParts[as.character(exonicParts$gene_id) == nmdGR$gene[i]]$tx_name[[1]][1]
        #as.character(exonicParts[as.character(exonicParts$gene_id) == nmdGR$gene[i]]$tx_name)[1]
    }))
addGR$exonic_part = sapply(1:length(nmdGR), function(i){
        max(exonicParts[as.character(exonicParts$gene_id) == nmdGR$gene[i]]$exonic_part) + nmdGR$addidx[i] 
    })
exonicParts = c(addGR, exonicParts)
exonicParts$nmd = FALSE 
exonicParts$nmd[1:length(addGR)]=TRUE
exonicParts = sort(exonicParts)

bamLst = BamFileList( dir(file.path(folder, "/alignment_filtered"),pattern="*bam$", full.names=TRUE), yieldSize=100000)
exonCounts <- summarizeOverlaps(exonicParts, bamLst,
    mode="Union",
    singleEnd=TRUE,
    ignore.strand=TRUE,
    ## this is for split reads
    inter.feature=FALSE)

outfolder = file.path(folder, "exon_comb")
if (!file.exists(outfolder))  dir.create(outfolder)

save(exonCounts, exonicParts, file=file.path(outfolder, "exonCounts.rda"))