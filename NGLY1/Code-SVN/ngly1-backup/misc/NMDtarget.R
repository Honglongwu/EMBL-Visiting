## nmd target defined by Regulation of Multiple Core Spliceosomal Proteins by Alternative Splicing-Coupled Nonsense-Mediated mRNA Decay [down-pointing small open triangle] †
# Arneet L. Saltzman, Yoon Ki Kim, [...], and Benjamin J. Blencowe
## coordinates updated by Xiaobin blast

library(GenomicRanges)
folder = "/g/steinmetz/wmueller/NGLY1/"
nmdTargetLines = readLines(file.path(folder, "hcluster/NMD.target1.txt"))
gp = sub("^>.*?_(.*?)_chr(.*?):(\\d*)-(\\d*)","\\1\t\\2\t\\3\t\\4",grep("^>",nmdTargetLines,value=TRUE))
nmdTarget = do.call(rbind, strsplit(gp,"\t"))
colnames(nmdTarget) =c("gene", "chr","start", "end")

outfolder = file.path(folder, "misc")
if (!file.exists(outfolder))  dir.create(outfolder)

write.table( nmdTarget, file=file.path(outfolder, "nmdTarget.txt"), quote = FALSE, sep = "\t",  row.names = FALSE)
warning("Correcting for Gene name needed manually\n")

nmdTarget = read.delim(file=file.path(outfolder, "nmdTarget_corrected.txt"), stringsAsFactors=FALSE, check.names=FALSE)
nmdGR= with(nmdTarget, GRanges(as.integer(chr), IRanges(start=as.integer(start), end=as.integer(end))))
nmdGR$gene = nmdTarget[, "gene_corrected"]
nmdGR$gene_alt = nmdTarget[, "gene"]
nmdGR= nmdGR[order(as.integer(as.character(seqnames(nmdGR))), start(nmdGR), end(nmdGR)) ]

require(biomaRt)
ensembl = useMart("ensembl",dataset="hsapiens_gene_ensembl")
bm = getBM(attributes=c('ensembl_gene_id',"wikigene_name"), filters='wikigene_name', values=nmdGR$gene , mart=ensembl)
nmdGR$ensembl = bm[match(nmdGR$gene, bm[, "wikigene_name"]), "ensembl_gene_id"]
nmdTarget$ensembl = bm[match(nmdTarget$gene_corrected, bm[, "wikigene_name"]), "ensembl_gene_id"]

save(nmdGR, nmdTarget, file=file.path(outfolder,"nmdTarget.rda") )