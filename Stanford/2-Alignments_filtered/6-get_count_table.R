# TODO: Add comment
# 
# Author: czhu
###############################################################################
library( "GenomicAlignments" )
library( "Rsamtools" )
library( "GenomicFeatures" )
library(BiocParallel)
register(MulticoreParam(workers = 30))

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
bamLst = BamFileList( dir(file.path(folder, "2-Alignments_filtered"),pattern="*.bam$", full.names=TRUE), yieldSize=100000)


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
pd1 = read.delim(file=file.path(folder, "1-Alignments/sampleAnnot-2014-10-21.formated.txt"), stringsAsFactors=FALSE, check.names=FALSE)
#pd = pd[,c("individual", "treatment", "biorep", "techrep", "label")]
pd1 = pd1[,c("sample", "biorep", "passage", "lane", "label")]

pd2 = read.delim(file=file.path(folder, "1-Alignments/sampleAnnot-2014-11-10.formated.txt"), stringsAsFactors=FALSE, check.names=FALSE)
#pd = pd[,c("individual", "treatment", "biorep", "techrep", "label")]
pd2 = pd2[,c("sample", "biorep", "passage", "lane", "label")]

pd3 = read.delim(file=file.path(folder, "1-Alignments/sampleAnnot-2014-11-12.formated.txt"), stringsAsFactors=FALSE, check.names=FALSE)
#pd = pd[,c("individual", "treatment", "biorep", "techrep", "label")]
pd3 = pd3[,c("sample", "biorep", "passage", "lane", "label")]

pd =  rbind(pd1, pd2, pd3)

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

save(exonsByGene, intronsByGene, geneCounts, exonCounts, intronCounts,  pd, file=file.path(folder, "Counts-2014-1011.rda"))
