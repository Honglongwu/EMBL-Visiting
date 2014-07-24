# getting exon counts, first merge overlapping exons 
# Author: czhu
###############################################################################
library( "GenomicAlignments" )
library( "Rsamtools" )
library( "GenomicFeatures" )
library(BiocParallel)
register(MulticoreParam(workers = 20))

folder = "/g/steinmetz/wmueller/NGLY1"

outfolder = file.path(folder, "exon-CP4")
if (!file.exists(outfolder))  dir.create(outfolder)

hsa=loadDb(file=file.path(folder, "genome/refGene.sqlite"))

exonicParts = disjointExons( hsa, aggregateGenes=FALSE )
seqlevels(exonicParts) =sub("chr", "", seqlevels(exonicParts)) 

bamLst = BamFileList( dir(file.path(folder, "/alignment_filtered"),pattern="*bam$", full.names=TRUE), yieldSize=100000)
exonCounts <- summarizeOverlaps(exonicParts, bamLst,
    mode="Union",
    singleEnd=TRUE,
    ignore.strand=TRUE,
    ## this is for split reads
    inter.feature=FALSE)

save(exonCounts, exonicParts, file=file.path(folder, "exon-CP4/exonCounts-CP4.rda"))
