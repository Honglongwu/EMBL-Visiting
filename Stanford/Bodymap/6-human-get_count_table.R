# TODO: Add comment
# 
# Author: czhu
###############################################################################
library( "GenomicAlignments" )
library( "Rsamtools" )
library( "GenomicFeatures" )
library(BiocParallel)
register(MulticoreParam(workers = 20))

folder = "/g/steinmetz/hsun/Stanford"

annotFile = file.path(folder, "data/hsa.sqlite") 
if(!file.exists(annotFile)) {
    GTFFILE = "/g/steinmetz/genome/Homo_sapiens/37.68/annotation/gtf/Homo_sapiens.GRCh37.68.gtf"
    warning("this takes a while to run\n")
    hsa <- makeTranscriptDbFromGFF( GTFFILE, format="gtf", species="Homo sapiens")
    saveDb(hsa,file=annotFile)
} else {
    hsa=loadDb(annotFile)
}

exonsByGene <- exonsBy( hsa, by="gene") 

#bamLst = BamFileList( dir(file.path(folder, "/alignment_filtered"),pattern="*bam$", full.names=TRUE), yieldSize=100000)
#bamLst = BamFileList( dir(file.path(folder, "2-Alignments_filtered"),pattern="*.bam$", full.names=TRUE), yieldSize=100000)
#bamLst = BamFileList( dir(file.path(folder, "2-Alignments_filtered"),pattern=".*(primary|immort).*.bam$", full.names=TRUE), yieldSize=100000)
bam = dir(file.path(folder, "Bodymap"),pattern=".*.bam$", full.names=TRUE)
bamLst = BamFileList(bam, yieldSize=100000)

geneCounts <- summarizeOverlaps( exonsByGene, bamLst,
    mode="Union",
    singleEnd=FALSE,
    ignore.strand=TRUE)

if (FALSE)
{
exonCounts <- summarizeOverlaps( unlist(exonsByGene), bamLst,
    mode="Union",
    singleEnd=TRUE,
    ignore.strand=TRUE,
    ## this is for split reads
    inter.feature=FALSE)

gs = genes(hsa)
myintrons =mclapply(1:length(gs), function(i) {
        gr = GenomicRanges::gaps(exonsByGene[[i]], start(gs)[i], end(gs)[i])
        gr = gr[!strand(gr) == "*"]
        subsetByOverlaps(gr,gs[i])       
    }, mc.cores=20)
intronsByGene = GRangesList(myintrons)
names(intronsByGene) = names(gs)
    
intronCounts <- summarizeOverlaps( intronsByGene, bamLst,
    mode="Union",
    singleEnd=TRUE,
    ignore.strand=TRUE)
}

#save(exonsByGene, intronsByGene, geneCounts, exonCounts, intronCounts, file=file.path(folder, "Counts-Human-Bodymap.rda"))
save(geneCounts, file=file.path(folder, "Bodymap/Counts-Human-Bodymap.rda"))
