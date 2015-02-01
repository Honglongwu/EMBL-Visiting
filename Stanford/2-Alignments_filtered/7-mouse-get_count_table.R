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

annotFile = file.path(folder, "data/mma.sqlite") 
if(!file.exists(annotFile)) {
    GTFFILE = "/g/steinmetz/hsun/Stanford/data/MouseGenome/Mus_musculus.GRCm38.73.gtf"
    warning("this takes a while to run\n")
    mma <- makeTranscriptDbFromGFF( GTFFILE, format="gtf", species="Mus musculus")
    saveDb(mma,file=annotFile)
} else {
    mma=loadDb(annotFile)
}

exonsByGene <- exonsBy( mma, by="gene") 

#bamLst = BamFileList( dir(file.path(folder, "/alignment_filtered"),pattern="*bam$", full.names=TRUE), yieldSize=100000)
bamLst = BamFileList( dir(file.path(folder, "2-Alignments_filtered"),pattern=".*(primary|immort).*.bam$", full.names=TRUE), yieldSize=100000)


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
pd1 = read.delim(file=file.path(folder, "1-Alignments/sampleAnnot-human-2014-10-21.formated.txt"), stringsAsFactors=FALSE, check.names=FALSE)
#pd = pd[,c("individual", "treatment", "biorep", "techrep", "label")]
pd1 = pd1[,c("sample", "biorep", "passage", "lane", "label")]

pd2 = read.delim(file=file.path(folder, "1-Alignments/sampleAnnot-mouse-2014-10-21.formated.txt"), stringsAsFactors=FALSE, check.names=FALSE)
#pd = pd[,c("individual", "treatment", "biorep", "techrep", "label")]
pd2 = pd2[,c("sample", "biorep", "passage", "lane", "label")]


pd3 = read.delim(file=file.path(folder, "1-Alignments/sampleAnnot-mouse-2014-11-10.formated.txt"), stringsAsFactors=FALSE, check.names=FALSE)
#pd = pd[,c("individual", "treatment", "biorep", "techrep", "label")]
pd3 = pd3[,c("sample", "biorep", "passage", "lane", "label")]

pd4 = read.delim(file=file.path(folder, "1-Alignments/sampleAnnot-human-2014-11-12.formated.txt"), stringsAsFactors=FALSE, check.names=FALSE)
#pd = pd[,c("individual", "treatment", "biorep", "techrep", "label")]
pd4 = pd4[,c("sample", "biorep", "passage", "lane", "label")]

pd =  rbind(pd1, pd2, pd3, pd4)
pd = pd[grepl("primary|immort",pd$label),]
## introns 
gs = genes(mma)
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

#save(exonsByGene, intronsByGene, geneCounts, exonCounts, intronCounts,  pd, file=file.path(folder, "Counts-Mouse-2014-1011.rda"))
save(exonsByGene, intronsByGene, geneCounts, exonCounts, intronCounts,  pd, file=file.path(folder, "Counts-Mouse-2014-1011-2.rda"))
