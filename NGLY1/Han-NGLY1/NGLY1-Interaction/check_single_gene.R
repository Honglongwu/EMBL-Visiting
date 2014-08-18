# check some control genes if the results are consisten with qPCR results
# Author: czhu
###############################################################################
##..##library(GenomicRanges)
library(DESeq2)

folder = "/g/steinmetz/wmueller/NGLY1/"
load(file.path(folder, "counts-CP4.rda"))
load(file.path(folder, "sampleAnnot-CP4.rda"))
load(file.path(folder, "gtf.rda"))

mat = assay(geneCounts)

wh = sampleAnnot$treatment == "DMSO"
sampleAnnot = droplevels(sampleAnnot[wh,])
mat = mat[, wh]

dds = DESeqDataSetFromMatrix(mat, sampleAnnot, design=~ individual)
dds = DESeq(dds)
rld = assay(rlog(dds, blind=FALSE))
save(rld, file='DESeq-ALL-DMSO-rld.rda')

symbol2id = function(symbo){
    ids$gene_id[ids$gene_name==symbo]
}

load('DESeq-ALL-DMSO-rld.rda')
plotFolder=file.path("/g/steinmetz/hsun/NGLY1/Han-NGLY1/NGLY1-Interaction", "single-gene-plot-check")
if (!file.exists(plotFolder))  dir.create(plotFolder)
sampleAnnot$individual = factor(c('19','CP1','CP2','CP3','CP4','MCP1','FCP1'))

#geneplot = function(genename,filename=paste0(gene,'.pdf')){
#pdf(file.path(plotFolder, filename), width=8, height=6)
#print(lattice::dotplot(rld[symbol2id(genename),]~sampleAnnot$individual, group=sampleAnnot$treatment,pch=19, auto.key=TRUE,ylab="Normalised gene expression"))
#dev.off()
#}
#geneplot('NGLY1')

geneplot = function(genename){
for(g in genename)
{
print(lattice::dotplot(rld[symbol2id(g),]~sampleAnnot$individual, 
                       group=sampleAnnot$individual,pch=19, auto.key=TRUE,
                       ylab="Normalised gene expression",main=g))
}
}

#genes=read.table('upf_drug_effect_six_samples.txt',header=F)
#pdf(file.path(plotFolder, 'upf_drug_effect_six_samples.pdf'), width=8, height=6)
#geneplot(genes[,1])
#dev.off()
#
#genes=read.table('upf_drug_effect_four_patients_minus_six_samples.txt',header=F)
#pdf(file.path(plotFolder, 'upf_drug_effect_four_patients_minus_six_samples.pdf'), width=8, height=6)
#geneplot(genes[,1])
#dev.off()
#
#genes=read.table('upf_drug_effect_four_patients_two_parents.txt',header=F)
#pdf(file.path(plotFolder, 'upf_drug_effect_four_patients_two_parents.pdf'), width=8, height=6)
#geneplot(genes[,1])
#dev.off()
#
#pdf(file.path(plotFolder, 'PTGS2.pdf'), width=8, height=6)
#geneplot('PTGS2')
#dev.off()

pdf(file.path(plotFolder, 'NGLY1.pdf'), width=8, height=6)
geneplot('NGLY1')
dev.off()

pdf(file.path(plotFolder, 'VCP.pdf'), width=8, height=6)
geneplot('VCP')
dev.off()










#pdf(file.path(plotFolder, "b2m.pdf"), width=8, height=6)
#lattice::dotplot(assay(rld)["ENSG00000166710",]~sampleAnnot$individual, group=sampleAnnot$treatment,auto.key=TRUE,
#    pch=19, ylab="Normalised gene expression", main="Beta 2 microglobulin")
#dev.off()

#pdf(file.path(plotFolder, "srsf2.pdf"), width=8, height=6)
#lattice::dotplot(assay(rld)["ENSG00000161547",]~sampleAnnot$individual, group=sampleAnnot$treatment, auto.key=TRUE,
#    pch=19, ylab="Normalised gene expression", main="SRSF2")
#dev.off()

