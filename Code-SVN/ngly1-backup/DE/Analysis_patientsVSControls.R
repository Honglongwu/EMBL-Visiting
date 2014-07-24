#call necessary libraries
library("DESeq2")

#set directory where the files are
directory <- "/Volumes/steinmetz/wmueller/NGLY1/DMSOvAzaC/DMSOcounts/"

#get all files with the *.txt
files <- system( paste("ls ", directory, "*.txt", sep=""), intern = T)

#function to read in the files, tab separated, and make them into columns with headers of the geneID and the fileName
getdata2 <- function(x) {
  input <- read.csv(x, header=F, sep="\t")
  filename <- strsplit(x, "/")
  filename <- filename[[1]][length(filename[[1]])]
  colnames(input) <- c("geneID",filename)
  return(input)
}

#read in all files
allConditions <- lapply(files, getdata2)

#merge tables into one
out <- allConditions[[1]]
for (i in 2:length(allConditions)) out <- merge(out, allConditions[[i]])
#for somev reason some files have too_low_aQual other __too_low_aQual, that's probably what created the problem

rownames(out) <- out$geneID
out <- out[,-1]



summedTotals = data.frame(
  fibro19_r1 = out$`19_DMSO_r1_l6_Counts.txt` + out$`19_DMSO_r1_l7_Counts.txt` + out$`19_DMSO_r1_l8_Counts.txt`,
  fibro19_r2 = out$`19_DMSO_r2_l6_Counts.txt` + out$`19_DMSO_r2_l7_Counts.txt` + out$`19_DMSO_r2_l8_Counts.txt`,
  FCP1_r1 = out$FCP1_DMSO_r1_l6_Counts.txt + out$FCP1_DMSO_r1_l7_Counts.txt + out$FCP1_DMSO_r1_l8_Counts.txt,
  FCP1_r2 = out$FCP1_DMSO_r2_l6_Counts.txt + out$FCP1_DMSO_r2_l7_Counts.txt + out$FCP1_DMSO_r2_l8_Counts.txt,
  MCP1_r1 = out$MCP1_DMSO_L7_1_Counts.txt + out$MCP1_DMSO_L8_1_Counts.txt,
  MCP1_r2 = out$MCP1_DMSO_L7_2_Counts.txt + out$MCP1_DMSO_L8_2_Counts.txt,
  CP1_r1 = out$CP1_DMSO_r1_l6_Counts.txt + out$CP1_DMSO_r1_l7_Counts.txt + out$CP1_DMSO_r1_l8_Counts.txt,
  CP1_r2 = out$CP1_DMSO_r2_l6_Counts.txt + out$CP1_DMSO_r2_l7_Counts.txt + out$CP1_DMSO_r2_l8_Counts.txt,
  CP2_r1 = out$CP2_DMSO_r1_l6_Counts.txt + out$CP2_DMSO_r1_l7_Counts.txt,
  CP2_r2 = out$CP2_DMSO_r2_l6_Counts.txt + out$CP2_DMSO_r2_l7_Counts.txt,
  CP3_r1 = out$CP3_DMSO_r1_l6_Counts.txt + out$CP3_DMSO_r1_l7_Counts.txt,
  CP3_r2 = out$CP3_DMSO_r2_l6_Counts.txt + out$CP3_DMSO_r2_l7_Counts.txt,
  row.names = rownames(out)
)
attributes <- strsplit(colnames(summedTotals), "_")
annotation <- data.frame(
  individual = sapply(attributes, function(x) x[1]),
  replicate = sapply(attributes, function(x) x[2]),
  NGLY1 = c("wt","wt","wt","wt","wt","wt","mut", "mut", "mut","mut","mut","mut"),
  gender = ifelse(as.numeric(summedTotals["ENSG00000012817",]) >100,"male","female"),
  family = c("other", "other", "wilsey","wilsey","wilsey","wilsey","wilsey","wilsey","other","other","other","other"),
  origin = ifelse(sapply(attributes, function(x) x[1]) == "fibro19", "dubious", "secure" )
  )

#cluster
sf <- estimateSizeFactorsForMatrix(summedTotals)
normed <- t(t(summedTotals) / sf)
normed <- normed[apply(normed,1,sum) >0, ]
cors <- cor(normed)
test <- hclust(as.dist(2-cors))

pca <- prcomp(t(normed), retx = T, center =T,scale.=T)
plotframe <- data.frame(PC1 = pca$x[,1], PC2 = pca$x[,2] , PC3 = pca$x[,3], annotation)
require(ggplot2)
pcaplot <- qplot(x = PC1, y=PC2, color = gender, data= plotframe, label = individual, geom="text") + theme_classic(base_size=22)

#what role does age play in this?
#from http://bioinformatics.oxfordjournals.org/content/25/7/875.short
# overexpressed_age <- c(347,2213,718,1191,1520,4069,3512,712,6277,2670,4494,713,3958,4257,306,308,6275,10457,2938,714,7450,79139,10397,360341,2212,2634,2799,90865,219972,10577,79602,567,9516,710,10870,57674,720,6696,25932,2202,7805,10493,3006,9813,10728,360231,22821,5717,6446,10628,16061,3039,3135,5046,10972,4478,306725,295217,715,1465,2896,3122,51228,7305,151636,26961,972,1512,2335,3303,6281,6385,22998,8780,8635,6272,115761,30845,3148,64805,716,80781,4170,11214,54511,3696,7018,11170,79026,1026,284194,57761,3109,54517,443,3300,83706,3134,4493,29901,51100,7307,382,3117,8502,2185,121536,1522,28960,3020,3689,4864,6430,64114,5348,2628,8935,4092,14728,23022,445,963,3732,1134,1312,1778,3043,3172,4204,8800,928,4057,5305,28959,307,1509,9314,3916,9961,4780,5331,5376,9588,6122,6558,9021,64844,84883,51421,466,999,3075,5269,55365,55108,14961,4507,10215,24145,10966,117039,309600,23137,633,1356,1410,2878,3459,3624,5696,7913,23118,6550,3315,728772,12722,26388,66676,192271,309122,65139,309584,287606,84025,4299,10462,2696,11129,10603,6814,968,54541,9987,8826,5138,5341,6096,8879,71073,93550,79864,85438,2214,54621,7107,259217,14862,20195,83687,29477,309622,967,2203,6902,126133,55196,58191,80314,54463,404636,64926,79191,12176,12484,19241,140609,473,162494,10417,57570,57602,2)
# underexpressed_age <- c(1281,7037,1277,1287,2170,518,54539,9315,27089,436430,793,7386,27069,55902,56616,6376,762,23788,2006,51495,64981,4711,66491,57704,28973,256691,84247,1351,19240,11258,9655,2805,79023,5800,299944,25940,6320,5406,292,268390,4722,1393,5828,5213,55930,51004,7390,7295,29796,79622,152789,8844,1290,4185,1620,990,81794,8313,653,116151,1289,4717,29942,5604,4712,84064,55298,108,10135,23705,1306,85480,128,8723,10456,486,4714,64838,442425,10078,2675,2806,1466,99104,5267,13109,7639,516,1453,304447,2571,25945,3157,9912,6664,57650,5717,498,53315,79017,3208,7353,515,4282,137392,482,6675,4729,3479,9737,522,203068,7436,9452,81873,1889,4190,2271,9554,4738,509,3336,57447,794,23786,10914,9588,8209,223082,64979,29103,6241,4677,221545,5723,6392,20250,113878,2160,6390,498525,170942,84302,81799,67704,79095)
# require(biomaRt)
# mart = useMart("ensembl", dataset="hsapiens_gene_ensembl")
# over_age_ensembl <-  getBM(attributes = "ensembl_gene_id" , filters = "entrezgene", values = overexpressed_age,mart=mart)
# under_age_ensembl <-  getBM(attributes = "ensembl_gene_id" , filters = "entrezgene", values = underexpressed_age,mart=mart)

#preformat for DESeq
#summed <- as.matrix(summed)
#colData <- data.frame(row.names=colnames(summed), 
#                      condition= c("untreated","untreated","untreated","untreated","untreated","untreated","untreated","untreated","treated","treated","treated","treated","treated","treated","treated")#,
#                      #xzççxzcΩxcvxcz≈cellLine= c("fibro1","fibro2","fibro3","fcp1","fcp2","fcp3","mcp1","mcp2","cp1_1","cp1_2","cp1_3","cp2_1","cp2_2","cp3_1","cp3_2")
#                      )
dds <- DESeqDataSetFromMatrix(countData=summedTotals, colData = annotation, design = ~ gender + family + origin + NGLY1, reduced = ~ gender + family + origin )# + cellLine)
dds <- DESeqDataSetFromMatrix(countData=summedTotals, colData = annotation, design = ~ gender + family + origin + NGLY1 )# + cellLine)

dds$NGLY1 <- relevel(dds$NGLY1, "wt")

#Run DeSeq
ndds = DESeq(dds, test="LRT", reduce=~ gender + family + origin)

dds <- DESeq(dds)
res <- results(dds)
res <- res[order(res$padj),]
res <- as.data.frame(na.omit(res))
stop()
#plots
#get entrez IDS
ensembl2entrez <-as.data.frame(org.Hs.egENSEMBL)
entrez <- sapply(rownames(res), function(x) {
  res<-ensembl2entrez$gene_id[ensembl2entrez$ensembl_id == x]
  if(length(res)>1) return(res[which.min(nchar(res))]) else if (length(res)==1) return(res) else return("")
})
entrez2alias <- as.data.frame(org.Hs.egSYMBOL)
alias <- sapply(entrez, function(x){
  res <- entrez2alias$symbol[entrez2alias$gene_id == x]
  if(length(res)>1) return(res[which.min(nchar(res))]) else if (length(res)==1) return(res) else return("")
}, USE.NAMES=T)

#Age
#how many genes total?
total <- sum(res$padj < 0.01)
age_related <- length(intersect(rownames(res), c(over_age_ensembl$ensembl_gene_id, under_age_ensembl$ensembl_gene_id)))
both <- length(intersect(rownames(res)[res$padj<0.01], c(over_age_ensembl$ensembl_gene_id, under_age_ensembl$ensembl_gene_id)))

testable <- matrix(c( both, age_related - both, total, nrow(res)-total ), nrow=2, byrow=T)
require(topGO)
topGOAnalysis <- function( geneIDs, inUniverse, inSelection )
  sapply( c( "MF", "BP", "CC" ), function( ont ) {
    alg <- factor( as.integer( inSelection[inUniverse] ) )
    names(alg) <- geneIDs[inUniverse]
    tgd <- new( "topGOdata", ontology=ont, allGenes = alg, nodeSize=5,
                annot=annFUN.org, mapping="org.Hs.eg.db" )
    resultTopGO <- runTest(tgd, algorithm = "elim", statistic = "Fisher" )
    GenTable( tgd, resultTopGO, topNodes=15 ) },
          simplify=FALSE )

#minMeanforGO <- min(res$baseMean[res$padj<0.001])
by_expression <- res[order(res$log2FoldChange),]
universe <- names(entrez) %in% rownames(by_expression)
nonNA = which(!is.na(by_expression$log2FoldChange))
subres = res[nonNA, ]

hits <- names(entrez) %in% rownames(subres[subres$padj < 0.01 & subres$log2FoldChange >0,])
goResults <- topGOAnalysis(entrez, universe, hits)

GO2entrez <- as.list(org.Hs.egGO2ALLEGS)
GOmembers <- mclapply(GO2entrez, function(x) {
  ensembl_go <-  names(entrez)[which(entrez %in% x)]
}, mc.cores=2)
