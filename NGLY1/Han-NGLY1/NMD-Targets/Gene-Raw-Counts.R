library(DESeq2)
folder = "/g/steinmetz/wmueller/NGLY1/"
load(file.path(folder, "counts-CP4.rda"))
load(file.path(folder, "sampleAnnot-CP4.rda"))
load(file.path(folder, "gtf.rda"))
symbol2id = function(symbo){
        ids$gene_id[ids$gene_name==symbo]
}

getname=function(x){
    s=unlist(strsplit(x,'[.]'))
    return(s[1])
}
geneCounts=assay(geneCounts)

rawCounts=function(genesymbol){
counts=geneCounts[rownames(geneCounts)==symbol2id(genesymbol),]
names(counts)=sapply(names(counts),getname)
return(counts)
}

gene = read.table('upf_drug_effect_six_samples.txt', header=F)[,1]
rc=lapply(gene,rawCounts)
names(rc) =  gene
write.table(data.frame(rc),'raw-counts-genes.txt',quote=F,col.names=NA)


#write.table(PTGS2,'NMD-Target-Gene.txt',quote=F,col.names=F,append=T)

