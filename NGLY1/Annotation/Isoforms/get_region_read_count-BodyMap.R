library(GenomicAlignments)
fls <- list.files('/g/tier2/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/preAligned/',
                   recursive=TRUE, pattern="*bam$", full=TRUE)
bfl <- BamFileList(fls)

features = GRanges(
seqnames = rep('3', times = 11),
ranges = IRanges(start = c(25760435,25770810,25824384,25819753,25824990,25775476,25777641,25777892,25824229,25825534,25831352), end = c(25760435,25772041,25824750,25820064,25825042,25777494,25777799,25778824,25824363,25825647,25831530)),'-',
group_id=c('ENST00000489271','ENST00000489271','ENST00000463611','ENST00000478991','ENST00000280700','ENST00000496726','ENST00000496726','ENST00000493324','ENST00000427041','ENST00000461491','ENST00000417874')
)
olap <- summarizeOverlaps(features, bfl, ignore.strand=TRUE)
save(assay(olap), 'ENSG00000151092-GRCh37-transcripts-unique-region2-counts.rda')
