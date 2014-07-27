# TODO: pairwise comparison between treat and control
# 
# Author: xxb0316
###############################################################################
library(GenomicRanges)
library(DESeq2)
library(doMC)
registerDoMC(cores=5)
library(made4)
library(RColorBrewer)
library(pvclust)
library(VennDiagram)

folder = "/g/steinmetz/wmueller/NGLY1"
load(file.path(folder, "counts-CP4.rda"))
load(file.path(folder, "sampleAnnot-CP4.rda"))
load(file.path(folder, "gtf.rda"))

## first look at gene counts
mat = assay(geneCounts)

## remove 19 for the moment
wh = which(sampleAnnot$individual != 19 )
sampleAnnot = droplevels(sampleAnnot[wh,])
mat = mat[, wh]

## pairwise comparison
pairwise.comp.func <- function(indi.name){
  
  mat.indi <- mat[,grepl(paste('^',indi.name,sep=''),colnames(mat))]
  dds = DESeqDataSetFromMatrix(mat.indi, sampleAnnot[sampleAnnot$individual == indi.name,], design=~treatment)
  dds = DESeq(dds)
  res = results(dds)
  res.df <- as.data.frame(res)
  res.df <- res.df[!is.na(res.df$padj),]
  res.df <- res.df[order(res.df$pvalue),]
  res.df$indi <- indi.name
  
  return(res.df)
  
}

de.pw.indi.list <- foreach(indi.name=unique(sampleAnnot$individual)) %dopar% pairwise.comp.func(indi.name)

outfolder="/g/steinmetz/wmueller/NGLY1/hcluster-CP4/" 

## find the shared up/down genes
## for up
venn.cols <- brewer.pal(12, 'Set3')[3:8]
up.gene.list <- lapply(de.pw.indi.list,function(x){rownames(subset(x,padj < 0.01 & log2FoldChange > 0))})
names(up.gene.list) <- unique(sampleAnnot$individual)

up.tmp <- venn.diagram(up.gene.list,filename=NULL,fill=venn.cols)
pdf(file.path(outdir,'venn.up.pdf'))
grid.draw(up.tmp)
dev.off()

down.gene.list <- lapply(de.pw.indi.list,function(x){rownames(subset(x,padj < 0.01 & log2FoldChange < 0))})
names(down.gene.list) <- unique(sampleAnnot$individual)

down.tmp <- venn.diagram(down.gene.list,filename=NULL,fill=venn.cols)
pdf(file.path(outfolder,'venn.down.pdf'))
grid.draw(down.tmp)
dev.off()

#hanice#
up.genes = sapply(up.gene.list,"[",seq(max(sapply(up.gene.list,length))))
write.table(up.genes, 'Treatment-up-Genes.txt',quote=F,row.names=F)
down.genes = sapply(down.gene.list,"[",seq(max(sapply(down.gene.list,length))))
write.table(down.genes, 'Treatment-down-Genes.txt',quote=F,row.names=F)

up.genes <- names(table(unlist(up.gene.list,use.name=FALSE)))[table(unlist(up.gene.list,use.name=FALSE)) == 6]
down.genes <- names(table(unlist(down.gene.list,use.name=FALSE)))[table(unlist(down.gene.list,use.name=FALSE)) == 6]







## annotate by go.R from Chenchen
library(org.Hs.eg.db)
library(topGO)

mygo= function(universe, hits, ontology) { 
  alg <- factor(as.integer( universe %in%  hits) )
  names(alg) <- universe
  tgd <- new( "topGOdata", ontology=ontology, allGenes = alg, nodeSize=5,
      annot=annFUN.org, mapping="org.Hs.eg.db", ID="ensembl" )
  resultTopGOElim <- runTest(tgd, algorithm = "elim", statistic = "Fisher" )
  resultTopGOClassicFisher <- runTest(tgd, algorithm = "classic", statistic = "Fisher" )
  list(it=tgd,
      ot=GenTable(tgd, classicFisher = resultTopGOClassicFisher , 
          elim = resultTopGOElim, orderBy = "elim", topNodes = 20, ranksOf="classicFisher"))    
}

#GO analysis
rv = mygo(rownames(dds.norm), up.genes, 'BP')

## how to get gene of interest
require(biomaRt)
ensembl = useMart("ensembl",dataset="hsapiens_gene_ensembl")
geneOfInt = genesInTerm(rv$it, "GO:0042555")

## how to annotate genes
getBM(attributes=c('ensembl_gene_id',"wikigene_name",'description', "phenotype_description"), filters='ensembl_gene_id', values=unlist(geneOfInt), mart=ensembl)

##cross annotated genes from GO with genes in RES, will print significant genes
enrichRes[rownames(enrichRes) %in% unlist(genesInTerm(rv$it, "GO:0042574")),]

#see all attributes 
listAttributes(ensembl)

listFilters(ensembl)




## find overlapped de genes in five indis

########################################hcluster for mat################################################################
dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design =~ individual + treatment)
dds <- estimateSizeFactors(dds)
dds.norm <- counts(dds,normalized=T)
colnames(dds.norm) <- sampleAnnot$label

## remove very low expressed genes in all samples
dds.norm <- dds.norm[rowSums(dds.norm) > 20,]

## replace top 5% gene count with quantile 95%
dds.norm <- apply(dds.norm,2,function(x){x[x > quantile(x,0.95)] <- quantile(x,0.95);return(x)})

count.norm <- dds.norm
count.norm <- t(scale(t(count.norm)))
count.norm <- pmin(pmax(count.norm, -3), 3)

#count.norm <- log2(count.norm+1)
#count.norm <- t(scale(t(count.norm)))
hclust.row <- hclust(as.dist(1-cor(t(count.norm), method="pearson")), method="complete")
hclust.col <- hclust(as.dist(1-cor(count.norm, method="spearman")), method="complete")

##plot.cols
plot.cols <- rev(colorRampPalette(brewer.pal(10, "RdBu"))(256))

##plot heatmap
pdf('/g/steinmetz/wmueller/NGLY1/hcluster-CP4/hcluster.heatplot.new.pdf',width=8,height=8)

heatmap.2(count.norm, Colv = as.dendrogram(hclust.col), Rowv = as.dendrogram(hclust.row), col = plot.cols, scale = 'none', trace = "none", density.info = "none")

dev.off()

#### to test sample clustering robust by bootstrap
fit.col <- pvclust(count.norm, method.hclust="complete",method.dist="correlation",use.cor='everything')
pdf('/g/steinmetz/wmueller/NGLY1/hcluster-CP4/pvclust.sample.pdf')
plot(fit.col)
pvrect(fit.col,alpha=0.9)
dev.off()
#####


#########################plot the normalized reads in up/down regulated genes################
gene.count.plot.func <- function(gene.list,pdf.name){
  
  pdf(paste('/g/steinmetz/wmueller/NGLY1/hcluster-CP4/',pdf.name,sep=''),height=10,width=10)
  par(mfrow=c(3,3),mar=c(5,2,4,2))
  point.cols <- c('brown','green4')[rep(c(1,1,2,2),times=6)]
  sample.labels <- unique(sub('DMSO.*','DMSO',sub('AzaC.*','AzaC',colnames(dds.norm))))
  
  lapply(gene.list,function(gene.name){
        
        gene.counts <- dds.norm[gene.name,]
        plot(rep(1:12,each=2),gene.counts,xaxt='n',xlab='',ylab='Normalized counts',main=gene.name,col=point.cols,cex=2)
        axis(side=1,labels=sample.labels,at=1:12,las=3)
        
      })
  
  dev.off()
 
}

## plot up/down genes
gene.count.plot.func(up.genes,'up.gene.count.norm.pdf')
gene.count.plot.func(down.genes,'down.gene.count.norm.pdf')

#########################plot the normalized reads in up/down regulated genes between CP and MCP/FCP################
up.cp.genes.all <- names(table(unlist(up.gene.list[1:4])))[table(unlist(up.gene.list[1:4])) == 4]
up.fm.genes.all <- names(table(unlist(up.gene.list[5:6])))[table(unlist(up.gene.list[5:6])) == 2]
up.cp.uni.genes <- up.cp.genes.all[!up.cp.genes.all %in% unique(unlist(up.gene.list[5:6]))]
gene.count.plot.func(up.cp.uni.genes,'up.cp.uni.gene.count.norm.pdf')

down.cp.genes.all <- names(table(unlist(down.gene.list[1:4])))[table(unlist(down.gene.list[1:4])) == 4]
down.fm.genes.all <- names(table(unlist(down.gene.list[5:6])))[table(unlist(down.gene.list[5:6])) == 2]
down.cp.uni.genes <- down.cp.genes.all[!down.cp.genes.all %in% unique(unlist(down.gene.list[5:6]))]
gene.count.plot.func(down.cp.uni.genes,'down.cp.uni.gene.count.norm.pdf')


#############################Find the DE exons########################################################################
library(Biostrings)
library(DEXSeq)
library(stringr)
tgt.exons.fsa <- readDNAStringSet('/g/steinmetz/wmueller/NGLY1/hcluster/NMD.target1.txt')

## count exon reads 
library('GenomicAlignments')
library('Rsamtools')
library('GenomicFeatures')
library(BiocParallel)
register(MulticoreParam(workers = 30))

## load annotation
hsa <- loadDb("/g/steinmetz/wmueller/NGLY1/hsa.sqlite")
exonsByGene <- exonsBy(hsa, by='gene')

## add extra exons
extra.exon.info <- names(tgt.exons.fsa)
extra.exon.GRanges <- GRanges(seqnames = as.integer(sub('chr','',str_extract(extra.exon.info,'chr\\d+'))), 
    ranges = IRanges(start=as.integer(sub(':','',str_extract(extra.exon.info,':\\d+'))),end=as.integer(sub('-','',str_extract(extra.exon.info,'-\\d+')))),
    exon_id = 1e6+1:length(extra.exon.info),exon_name = sub('_chr.*','',extra.exon.info))

## read bam files
bamLst = BamFileList(dir('/g/steinmetz/wmueller/NGLY1/alignment_filtered/',pattern="*bam$", full.names=TRUE), yieldSize=100000)

exonCounts <- summarizeOverlaps(c(unlist(exonsByGene),extra.exon.GRanges), bamLst,
    mode="Union",
    singleEnd=TRUE,
    ignore.strand=TRUE,
    ## this is for split reads
    inter.feature=FALSE)

rownames(exonCounts) <- c(unlist(exonsByGene),extra.exon.GRanges)$exon_id

## find DE exons
load('/g/steinmetz/wmueller/NGLY1/sampleAnnot.rda')
sampleAnnot <- subset(sampleAnnot, individual != 19)

fID = as.character(unlist(sapply(exonsByGene,function(x) values(x)$exon_id)))
gID = rep(names(exonsByGene),sapply(exonsByGene,length))

dxd = DEXSeqDataSet(mat, sampleAnnot,
    design= ~ individual + treatment + treatment:exon,
    featureID=fID, 
    groupID=gID
#,featureRanges=exonsByGene
)

