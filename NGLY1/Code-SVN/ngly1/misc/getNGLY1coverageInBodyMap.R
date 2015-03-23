# Date: 25 June 2014
#
# Author: jaerveli
#
# Description:
#
# 	Plotting Illumina BodyMap coverage for NGLY exon 8.
# 
# # # # # # # # # # # # # # # # # # # # # # # #

library(IRanges)
library(GenomicRanges)
library(ShortRead)
library(RColorBrewer)



## ## ## ## HARDCODED PARAMETERS

cols <- colorRampPalette(brewer.pal(8,"Dark2"))(length(coverages_plus)) ### CHANGE TO 16 FOR 16 TISSUES
gene_id = 'ENSG00000151092'
window = 1000

# 'exon 8' (~ 3:25,775,370-25,775,460) CHANGE THIS TO LOOK AT OTHER REGIONS
regionOfInterest =  c(25775370,25775460)
# Plot an area slightly larger than exon
region = c(regionOfInterest[1] - 100, regionOfInterest[2] + 100)

gtf='/g/steinmetz/genome/Homo_sapiens/37.68/annotation/gtf/Homo_sapiens.GRCh37.68.chrOnly.gtf'



## ## ## ## WHERE THE DATA IS

bamFiles = c( 
'/g/tier2/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/preAligned/GRCh37.HumanBodyMap.adrenal.1.filtered.sorted.bam',
'/g/tier2/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/preAligned/GRCh37.HumanBodyMap.brain.1.filtered.sorted.bam',
'/g/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/preAligned/GRCh37.HumanBodyMap.ovary.1.filtered.sorted.bam',
'/g/tier2/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/preAligned/GRCh37.HumanBodyMap.breast.1.filtered.sorted.bam',
'/g/tier2/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/preAligned/GRCh37.HumanBodyMap.kidney.1.filtered.sorted.bam',
'/g/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/restOfFiltered2/GRCh37.HumanBodyMap.thyroid.1.filtered.sorted.bam',
'/g/tier2/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/restOfFiltered/GRCh37.HumanBodyMap.lymph.1.filtered.sorted.bam',
'/g/tier2/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/preAligned/GRCh37.HumanBodyMap.heart.1.filtered.sorted.bam',
'/g/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/restOfFiltered2/GRCh37.HumanBodyMap.testes.1.filtered.sorted.bam',
'/g/tier2/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/preAligned/GRCh37.HumanBodyMap.adipose.1.filtered.sorted.bam',
'/g/tier2/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/preAligned/GRCh37.HumanBodyMap.lung.1.filtered.sorted.bam',
'/g/tier2/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/restOfFiltered/GRCh37.HumanBodyMap.prostate.1.filtered.sorted.bam',
'/g/tier2/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/preAligned/GRCh37.HumanBodyMap.colon.1.filtered.sorted.bam',
'/g/tier2/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/preAligned/GRCh37.HumanBodyMap.blood.1.filtered.sorted.bam',
'/g/tier2/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/preAligned/GRCh37.HumanBodyMap.liver.1.filtered.sorted.bam',
'/g/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/restOfFiltered2/GRCh37.HumanBodyMap.skeletal_muscle.1.filtered.sorted.bam'
)

tissues = c(
        'adrenal',
        'brain',
        'ovary',
        'breast',
        'kidney',
        'thyroid',
        'lymph',
        'heart',
        'testes',
        'adipose',
        'lung',
        'prostate',
        'colon',
        'blood',
        'liver',
        'skeletal_muscle' )


## Info on library sizes for normalization

libSizes = read.delim( '/g/steinmetz/project/mTEC_Seq/externalData/IlluminaBodyMap/info/librarySizes.tsv' )



## ## ## ## HELPER FUNCTIONS

getExonIntronBoundaries = function(x) {
	introns = setdiff(IRanges( start=min(x$V4), max(x$V5)), IRanges( start=x$V4, end=x$V5) )
	exons = setdiff(IRanges( start=min(x$V4), max(x$V5)), introns )
	e = cbind( as.data.frame(exons), type=rep('exon', length(exons)))
	i = cbind( as.data.frame(introns), type=rep('intron', length(introns)))
	return( rbind(e,i) )
}

getCdsBoundaries = function(x) {
	gene = IRanges( start=min(x$V4), max(x$V5))
	nonCDS = setdiff( gene, IRanges( start=x$V4, end=x$V5) )
	cds = setdiff( gene, nonCDS )
	return( as.data.frame(cds) )
}

getScaledCoverage = function( coverage=coverage, region=region, libSize=libSize ) {
	
	cov = as.vector( window( coverage(coverage)$'3', region[1], region[2] ))
	names(cov) = region[1]:region[2]

	coverage_TPM = 1000000*cov/libSize
	names(coverage_TPM) = names(cov)

	# Scale between 0 and 1
	coverage_TPM_scaled = scale(coverage_TPM, center = min(coverage_TPM), scale = max(coverage_TPM) - min(coverage_TPM))[,1]
	
	# return
	return(coverage_TPM_scaled)
}


getCoverage = function( coverage=coverage, region=regione ) {
	
	cov = as.vector( window( coverage(coverage)$'3', region[1], region[2] ))
	names(cov) = region[1]:region[2]

	# return
	return(cov)
}


plotProfile = function(coverage = coverage, region = region, tissue = tissue) {
	
	plot( as.integer(names(coverage)), type = 'l', lty = 2, coverage, xlab='Genomic coordinate on chromosome 3', ylab = 'Coverage (read count)', main = paste( "Expression of exon 8\nin", tissue, "tissue") )

	abline(h=0, col="#00000080")
	txModelAt = -0.05
	cdsModelAt = -0.1
	
	# Introns
	if(length(ia[,1]) > 0) {
		for(i in 1:length(ia[,1]) ) {
			start=ia[i,'start']
			end=ia[i,'end']
			lines( start:end, rep.int(txModelAt, length(start:end)), lwd=1, col='grey') # , cex=0.8 
		}
	}
	
	# Exons
	for(i in 1:length(ea[,1]) ) {
		start=ea[i,'start']
		end=ea[i,'end']
		lines( start:end, rep.int(txModelAt, length(start:end)), lwd=5, col='black') # , cex=0.8
	}
	
	# CDS
	if(length(cds[,1]) > 0) {
		for(i in 1:length(cds[,1]) ) {
			start=cds[i,'start']
			end=cds[i,'end']
			lines( start:end, rep.int(cdsModelAt, length(start:end)), lwd=5, col='#0000FF70') # , cex=0.8
		}
	}
	
	# TSSs
	for(tss in TSS ) {
		start=tss - 1
		end=tss + 1
		lines( start:end, rep.int(txModelAt, length(start:end)), lwd=5, col="yellowgreen" ) # , cex=0.8
	}

}


plotProfileAll = function(coverages_plus= coverages_plus, region=region, cols=cols) {

	plot(NA, xlim=region, ylim = c(-0.15,1), xlab='Genomic coordinate on chromosome 3', ylab = 'Scaled coverage', main = "Expression of exon 8\nin Illumina BodyMap" )
	lapply(1:length(coverages_plus), function(x) {
		lines( region[1]:region[2], coverages_plus[[x]], lty = 2, col = cols[x] )
		return()
	}) 
	legend("topleft", legend=names(coverages_plus), col=cols, lty = 2, text.col=cols, cex = 0.9, bty='n')

	abline(h=0, col="#00000080")
	txModelAt = -0.05
	cdsModelAt = -0.1
	
	# Introns
	if(length(ia[,1]) > 0) {
		for(i in 1:length(ia[,1]) ) {
			start=ia[i,'start']
			end=ia[i,'end']
			lines( start:end, rep.int(txModelAt, length(start:end)), lwd=1, col='grey') # , cex=0.8 
		}
	}
	
	# Exons
	for(i in 1:length(ea[,1]) ) {
		start=ea[i,'start']
		end=ea[i,'end']
		lines( start:end, rep.int(txModelAt, length(start:end)), lwd=5, col='black') # , cex=0.8
	}
	
	# CDS
	if(length(cds[,1]) > 0) {
		for(i in 1:length(cds[,1]) ) {
			start=cds[i,'start']
			end=cds[i,'end']
			lines( start:end, rep.int(cdsModelAt, length(start:end)), lwd=5, col='#0000FF70') # , cex=0.8
		}
	}
	
	# TSSs
	for(tss in TSS ) {
		start=tss - 1
		end=tss + 1
		lines( start:end, rep.int(txModelAt, length(start:end)), lwd=5, col="yellowgreen" ) # , cex=0.8
	}
}



## ## ## ## ANNOTATION FOR PLOTTING

gtf = read.delim(gtf, header=F)
exons = gtf[which(gtf$V3=='exon'),]
ngly1 = exons[grep(gene_id, exons$V9),]

ngly1_codingExon = ngly1[ which(ngly1$V2 =='protein_coding'), ]
ei = getExonIntronBoundaries(ngly1_codingExon)
ea = ei[which(ei$type=='exon'),]
ia = ei[which(ei$type=='intron'),]

cds = gtf[which(gtf$V3=='CDS'),]
ngly1_cds = cds[grep(gene_id, cds$V9),]
cds = getCdsBoundaries( unique(ngly1_cds[,c(1,4,5,7)]) )

tx_ids = unlist( lapply( as.character(ngly1_codingExon$V9), function( x ) { sub( ' ', '', strsplit( strsplit(x, '; ')[[1]][grep( 'transcript_id', strsplit(x, '; ')[[1]] )], 'transcript_id' )[[1]][2]) }) )
TSS = as.numeric(by(ngly1_codingExon$V5, tx_ids, max))



## ## ## ##  EXTRACT REGIONS FROM NGLY1 REGION 

chr = ngly1$V1[1]
rangeStart = min(ngly1$V4) - window
rangeEnd = max(ngly1$V5) + window
param <- ScanBamParam(what=c("pos", "qwidth", "strand"), which=GRanges(chr, IRanges(rangeStart, rangeEnd), strand = Rle('+')), flag=scanBamFlag(isUnmappedQuery=FALSE))

aln = lapply(bamFiles, readGAlignmentsFromBam, param=param)
names(aln) = tissues



## ## ## ## CALCULATE COVERAGE

## ## Calculate TPM coverage for each tissue, scale all 0-1. 

coverages_plus = lapply( 1:length(aln), function(x) {
	coverage = aln[[x]]
	coverage = coverage[ which(elementMetadata(coverage)$strand=='+')]
	tissue = tissues[x]
	libSize = libSizes[ which( libSizes$tissue == tissue), ]$reads
	coverage_TPM_scaled = getScaledCoverage( coverage=coverage, region=region, libSize=libSize )
	return(coverage_TPM_scaled)
})
names(coverages_plus) = tissues

coverages_minus = lapply( 1:length(aln), function(x) {
	coverage = aln[[x]]
	coverage = coverage[ which(elementMetadata(coverage)$strand=='-')]
	tissue = tissues[x]
	libSize = libSizes[ which( libSizes$tissue == tissue), ]$reads
	coverage_TPM_scaled = getScaledCoverage( coverage=coverage, region=region, libSize=libSize )
	return(coverage_TPM_scaled)
})
names(coverages_minus) = tissues



## ## ## ## PLOT COVERAGE

png('/g/steinmetz/jaerveli/tmp/ngly1/tissues-together-plus.png', width=700, height=700)
plotProfileAll(coverages_plus= coverages_plus, region=region, cols=cols)
dev.off()

# Plot
png('/g/steinmetz/jaerveli/tmp/ngly1/tissues-together-minus.png', width=700, height=700)
plotProfileAll(coverages_plus = coverages_minus, region=region, cols=cols)
dev.off()



## ## ## ## CALCULATE COVERAGE (without normalization or scaling)

coverages_count_plus = lapply( 1:length(aln), function(x) {
	coverage = aln[[x]]
	coverage = coverage[ which(elementMetadata(coverage)$strand=='+')]
	tissue = tissues[x]
	coverage = getCoverage( coverage=coverage, region=region )
	return(coverage)
})
names(coverages_count_plus) = tissues

coverages_count_minus = lapply( 1:length(aln), function(x) {
	coverage = aln[[x]]
	coverage = coverage[ which(elementMetadata(coverage)$strand=='-')]
	tissue = tissues[x]
	coverage = getCoverage( coverage=coverage, region=region )
	return(coverage)
})
names(coverages_count_minus) = tissues




## ## Plot all tissues separately, counts rather than scaled counts

png('/g/steinmetz/jaerveli/tmp/ngly1/tissues-separate-plus.png', width = 1200, height = 1200)
par(mfrow=c(4,4))
lapply(1:length(coverages_count_plus), function(x) { plotProfile( coverage = coverages_count_plus[[x]], region = region, tissue = tissues[x] ) } )
dev.off()

png('/g/steinmetz/jaerveli/tmp/ngly1/tissues-separate-minus.png', width = 1200, height = 1200)
par(mfrow=c(4,4))
lapply(1:length(coverages_count_minus), function(x) { plotProfile( coverage = coverages_count_minus[[x]], region = region, tissue = tissues[x] ) } )
dev.off()

