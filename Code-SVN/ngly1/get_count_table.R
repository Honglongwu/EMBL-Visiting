# TODO: Add comment
# 
# Author: czhu
###############################################################################
library( "GenomicAlignments" )
library( "Rsamtools" )
library( "GenomicFeatures" )
library(BiocParallel)
register(MulticoreParam(workers = 30))

folder = "/g/steinmetz/wmueller/NGLY1"

annotFile = file.path(folder, "hsa.sqlite") 
if(!file.exists(annotFile)) {
    GTFFILE = "/g/steinmetz/genome/Homo_sapiens/37.68/annotation/gtf/Homo_sapiens.GRCh37.68.gtf"
    warning("this takes a while to run\n")
    hsa <- makeTranscriptDbFromGFF( GTFFILE, format="gtf", species="Homo sapiens")
    saveDb(hsa,file=annotFile)
} else {
    hsa=loadDb(file=file.path(folder, "hsa.sqlite"))
}

exonsByGene <- exonsBy( hsa, by="gene") 

bamLst = BamFileList( dir(file.path(folder, "/alignment_filtered"),pattern="*bam$", full.names=TRUE), yieldSize=100000)

geneCounts <- summarizeOverlaps( exonsByGene, bamLst,
    mode="Union",
    singleEnd=TRUE,
    ignore.strand=TRUE)

exonCounts <- summarizeOverlaps( unlist(exonsByGene), bamLst,
    mode="Union",
    singleEnd=TRUE,
    ignore.strand=TRUE,
    ## this is for split reads
    inter.feature=FALSE)

## pheno data
pd = read.delim(file=file.path(folder, "samples-CP4.txt"), stringsAsFactors=FALSE, check.names=FALSE)
pd = pd[,c("individual", "treatment", "biorep", "techrep", "label")]

## introns 
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

save(exonsByGene, intronsByGene, geneCounts, exonCounts, intronCounts,  pd, file=file.path(folder, "counts-CP4.rda"))
