## 

folder = "/g/steinmetz/wmueller/NGLY1/"

infile = file.path(folder, "DE_ngly1/pairWiseComparison/resMCP1vCP1.rda")
load(infile)

dat = res
colnames(dat) = paste0("MCP1vCP1.", colnames(dat))

infile = file.path(folder, "DE_ngly1/pairWiseComparison/resFCP1vCP23.rda")
load(infile)
subdat = res[,-(7:8)]
colnames(subdat) = paste0("FCP1vCP23.", colnames(subdat))
dat = cbind(dat, subdat[match(rownames(dat), rownames(subdat)),])


## mouse data
infile = file.path(folder, "tadashi/MEF/htseqMEF/resMefWtVsNglyKO.rda")
load(infile)


## how to get gene of interest
require(biomaRt)
ensembl = useMart("ensembl",dataset="hsapiens_gene_ensembl")
#mouse
mensembl = useMart("ensembl",dataset="mmusculus_gene_ensembl")
#compare output with Mus Musculus MEF NGLY1 KO output
#mouse data in /g/steinmetz/wmueller/NGLY1/tadashi/MEF/htseqMEF/    
#file used for comparison to NGLY1 fibroblast lines was resMefWtVsNglyKO.rda
#genes with abs(log2foldchange) > 1 were used for comparison
orthoList = getLDS(attributes = c('ensembl_gene_id'), filters='ensembl_gene_id', values = rownames(res), mart = mensembl, attributesL = c('ensembl_gene_id'), martL = ensembl)
sp =split(orthoList[,1], orthoList[,2])
sp = sp[sapply(sp,length)==1]
sp = unlist(sp)
mouseRes = res
colnames(mouseRes) = paste0("mouse.", colnames(mouseRes))
dat = cbind(dat, sp[rownames(dat)])
colnames(dat)[ncol(dat)] = "mouseName"

isnotNA = which(!is.na(dat[, "mouseName"]))
mydat = cbind(dat[isnotNA, ], mouseRes[match(dat[isnotNA, "mouseName"], rownames(mouseRes)),])

#add column of age related genes
age = read.delim(file = "genage_human.txt", header = T, sep='\t')
am = mydat$MCP1vCP1.gene_name %in% age$symbol_hugo
mydat$ageRelatedGene = am

#add column of mitochondiral related genes
load(file.path(folder, "/mito/mitoMapGeneSet.rda"))
tab = read.delim(file=file.path(folder, "/mito/Human.MitoCarta.txt"), stringsAsFactors=FALSE, check.names=FALSE)
#combine lists
m1 = tab$SYM
m2 = as.character(mitoMapGenes$V1) 
mList = c(m1,m2)
mList = gsub(" ", "", mList)
mList = gsub("\\(.*\\)", "", mList)
mm = mydat$MCP1vCP1.gene_name %in% mList
mydat$mitoRelatedGenes = mm

#UPR genes
upr = read.delim(file = "UPRlist.txt", header = T, sep = "\t")
uprList = as.character(upr$Symbol)
uprList = gsub(" ", "", uprList)
um = mydat$MCP1vCP1.gene_name %in% uprList
mydat$uprRelatedGene = um

#ERAD related genes
erad = read.delim(file = "ERAD.txt", header = F, sep = "\t")
e1 = as.character(unique(erad[,1]))
e1 = toupper(e1)
e1 = gsub("-", "", e1)
e2 = as.character(unique(erad[,2]))
e2 = toupper(e2)
e2 = gsub("-", "", e2)
eList = c(e1,e2)
eList = gsub("DERLIN", "DERL", eList)
eList = gsub("BIP/GRP78", "HSPA5", eList)
eList = unique(eList)
em = mydat$MCP1vCP1.gene_name %in% eList
mydat$ERADrelatedGene = em

save(mydat, file = "DE_ngly1/combineDat.rda")

mouseMatch = which(mydat$MCP1vCP1.log2FoldChange < 0 & mydat$FCP1vCP23.log2FoldChange < 0 & mydat$mouse.log2FoldChange < 0)
mouseMatch = mydat[mouseMatch,]
relaxDown = mouseMatch[which(mouseMatch$MCP1vCP1.padj < 0.05 & mouseMatch$FCP1vCP23.padj < 0.05),]

#remove duplicates based on a particular column 
#newData = subset(oldData, !duplicated(columnWithDuplicates)) 
umoList = subset(moList, !duplicated(human.Ens.Gene.ID))

#ONLY DONE FOR AZAC SPECIFIC TREATMENt
pdatu = read.table(file = "up.genes.txt", header = T)
xm = rownames(res) %in% pdatu$up.genes
res$pairwise_sig_UP = xm

pdatd = read.table(file = "down.genes.txt", header = T)
xm = rownames(res) %in% pdatd$down.genes
res$pairwise_sig_DOWN = xm

save(mydat, file = "drug_effect/combineDat.rda")








