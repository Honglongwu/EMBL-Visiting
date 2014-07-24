#require(biomaRt)
#ensembl = useMart("ensembl",dataset="hsapiens_gene_ensembl")
#goids = getBM(attributes=c('ensembl_gene_id','go_id'), filters='ensembl_gene_id', values="ENSG00000128652", mart=ensembl)
################################################################################
library(org.Hs.eg.db) 
library(topGO)
#mouse = library(org.Mm.eg.db)


#load results from deseq2 run from file DESeq_ngly1_effect.R
folder = "/g/steinmetz/wmueller/NGLY1/DE_ngly1"
load(file.path(folder, "res.rda"))

mygo= function(universe, hits, ontology) { 
    alg <- factor( as.integer( universe %in%  hits) )
    names(alg) <- universe
    tgd <- new( "topGOdata", ontology=ontology, allGenes = alg, nodeSize=5,
        annot=annFUN.org, mapping="org.Hs.eg.db", ID="ensembl" ) #mouse = org.Mm.eg.db
    resultTopGOElim <- runTest(tgd, algorithm = "elim", statistic = "Fisher" )
    resultTopGOClassicFisher <- runTest(tgd, algorithm = "classic", statistic = "Fisher" )
    list(it=tgd,
        ot=GenTable(tgd, classicFisher = resultTopGOClassicFisher , 
            elim = resultTopGOElim, orderBy = "elim", topNodes = 20, ranksOf="classicFisher"))    
}

## only these we have p value and log fold change up or down dependent on the subres$log2FoldChange 
wh = which(!(is.na(res$log2FoldChange) | is.na(res$padj)))
subres = droplevels(as.data.frame(res[wh,]))
enrichRes = subres[subres$padj < 0.01,]
#alter subres$log2FoldChange < 0 to > 0 for up regulated genes
sel = subres$padj < 0.01 & subres$log2FoldChange > 0  #0.0000001 for MCPvCP1 comparison, 0.0001 for FCP v CP23

#GO analysis
rv = mygo(rownames(subres), rownames(subres)[sel], "BP")

## how to get gene of interest
require(biomaRt)
ensembl = useMart("ensembl",dataset="hsapiens_gene_ensembl")
geneOfInt = genesInTerm(rv$it, "GO:0002691")

#mouse
mensembl = useMart("ensembl",dataset="mmusculus_gene_ensembl")

## how to annotate genes
getBM(attributes=c('ensembl_gene_id',"wikigene_name",'description', "phenotype_description"), filters='ensembl_gene_id', values=unlist(geneOfInt), mart=ensembl)

##cross annotated genes from GO with genes in RES, will print significant genes
enrichRes[rownames(enrichRes) %in% unlist(genesInTerm(rv$it, "GO:0042574")),]

#see all attributes 
listAttributes(ensembl)

listFilters(ensembl)

#compare output with Mus Musculus MEF NGLY1 KO output
#mouse data in /g/steinmetz/wmueller/NGLY1/tadashi/MEF/htseqMEF/    
#file used for comparison to NGLY1 fibroblast lines was resMefWtVsNglyKO.rda
#genes with abs(log2foldchange) > 1 were used for comparison
orthoList = getLDS(attributes = c('ensembl_gene_id'), filters='ensembl_gene_id', values = rownames(enrichRes), mart = mensembl, attributesL = c('ensembl_gene_id',"wikigene_name"), martL = ensembl)

wm = which(orthoList$Ensembl.Gene.ID.1 %in% rownames(enrichRes))
enrichRes[wm,]



