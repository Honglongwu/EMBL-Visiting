# Author: czhu
###############################################################################

seqFolders = c(#"/g/steinmetz/incoming/solexa/2014-05-26-C3PJ9ACXX",
    #"/g/steinmetz/incoming/solexa/2014-03-25-C365AACXX",
    #"/g/steinmetz/incoming/solexa/2014-05-23-C3PJ2ACXX"),
    "/g/steinmetz/incoming/solexa/2014-07-22-C3NVAACXX")

get_demultiplxed_fileinfo = function(x){
    cmd = paste("find",x, "-type f -name *barcode* 2>/dev/null")
    op = system(cmd, intern=TRUE)
    do.call(rbind, lapply(op,read.delim,header=FALSE,stringsAsFactors=FALSE))
}

fileAnnot = do.call(rbind, lapply(seqFolders, get_demultiplxed_fileinfo))
colnames(fileAnnot) = c("sampleName","barcode","file")
fileAnnot$lane = sub(".*(lane\\d).*","\\1", fileAnnot$file)
fileAnnot$name = with(fileAnnot, paste(sampleName,lane,sep="_"))

folder = "/g/steinmetz/wmueller/NGLY1"
outfile = file.path(folder, "sampleAnnot-CP4.txt")
if(file.exists(outfile)){
    stop("Are you sure you want to rewrite the annotation file?\n")
} else {
    write.table( fileAnnot, file=outfile, quote = FALSE, sep = "\t",  row.names = FALSE)    
}

## build transcript index, do it only once, but saves a lot time for multiples files
#tophat -G /g/steinmetz/genome/Homo_sapiens/37.68/annotation/gtf/Homo_sapiens.GRCh37.68.gtf --transcriptome-index=/g/steinmetz/genome/Homo_sapiens/37.68/annotation/gtf/GRCh37.68.transcriptome.index /g/steinmetz/genome/Homo_sapiens/37.68/indexes/bowtie2/Homo_sapiens.GRCh37.68.withIVTs

run_tophat = function(x,o,ncpu=25) {
    cmd = paste("tophat --read-gap-length 3 --read-edit-dist 3  --b2-sensitive -p",ncpu,
        "-o",o, "--transcriptome-index=/g/steinmetz/genome/Homo_sapiens/37.68/annotation/gtf/GRCh37.68.transcriptome.index", 
        "/g/steinmetz/genome/Homo_sapiens/37.68/indexes/bowtie2/Homo_sapiens.GRCh37.68.withIVTs", 
        x)
    cat(cmd,"\n")
    system(cmd)
}

outfolder = "/g/steinmetz/wmueller/NGLY1/alignments"
if (!file.exists(outfolder))  dir.create(outfolder)

for(i in 1:nrow(fileAnnot)){
    run_tophat(fileAnnot$file[i], file.path(outfolder, fileAnnot$name[i]),ncpu=30)
}

#rerunFiles = c(
#    "/g/steinmetz/incoming/solexa/2014-05-26-C3PJ9ACXX/lane7/LIB16975_RBA16694/fastq/ngly1_CP1_DMSO_rep1_LIB16975_RBA16694_1.txt.gz", 
#    "/g/steinmetz/incoming/solexa/2014-05-26-C3PJ9ACXX/lane7/LIB16976_RBA16695/fastq/ngly1_CP1_DMSO_rep2_LIB16976_RBA16695_1.txt.gz", 
#    "/g/steinmetz/incoming/solexa/2014-03-25-C365AACXX/lane7/LIB16529_RBA16189/fastq/ngly1_ngly1_MCP1_20uM_AzaC_rep1_LIB16529_RBA16189_1.txt.gz" 
#)
#
#ma = match(rerunFiles, fileAnnot$file)
#for(i in 1:nrow(fileAnnot[ma,])){
#    run_tophat(fileAnnot[ma,]$file[i], file.path(outfolder, fileAnnot[ma,]$name[i]),ncpu=30)
#}
