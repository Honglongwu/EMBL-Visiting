
folder = "/g/steinmetz/wmueller/NGLY1"

tab = read.delim(file=file.path(folder, "/mito/Human.MitoCarta.txt"), stringsAsFactors=FALSE, check.names=FALSE)


## getting ensembl id and more if you want
require(biomaRt)
ensembl = useMart("ensembl",dataset="hsapiens_gene_ensembl")
ids = getBM(attributes=c('ensembl_gene_id', "entrezgene", "wikigene_name", "description"), filters='entrezgene', values=tab[, "HUMAN ENTREZ"], mart=ensembl)
ids = ids[grep("^ENSG", ids[,1]),]

load(file.path(folder, "DE_ngly1/res.rda"))

subres = res[rownames(res) %in% ids[, "ensembl_gene_id"], ]

head(subres[order(subres$padj),])
myres = cbind(subres, ids[match(rownames(subres), ids[, "ensembl_gene_id"]),c("wikigene_name", "description")])

head(myres,20)

wh = which(!(is.na(res$log2FoldChange) | is.na(res$padj)))
subres = droplevels(as.data.frame(res[wh,]))
#sel = subres$padj < 0.001 & subres$log2FoldChange < 0

hits = rownames(subres[subres$padj <0.01,])
## genes regulated and mito related
myres[rownames(myres) %in% hits[hits %in% ids[,1]],]

mat = matrix(c(sum(hits %in% ids[,1]),length(hits)-sum(hits %in% ids[,1]),
length(hits),
nrow(subres)-length(hits)-sum(hits %in% ids[,1])),nc=2)

load(file.path(folder, "/mito/mitoMapGeneSet.rda"))

miToids = getBM(attributes=c('ensembl_gene_id', "wikigene_name", "description"), filters='mim_gene_accession', values=mitoMapGenes[, 2], mart=ensembl)
miToids = miToids[grep("^ENSG", miToids[,1]),]

