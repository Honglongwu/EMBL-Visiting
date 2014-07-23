# merging the technical replicates easier for IGV browsing
# Author: czhu
###############################################################################
folder = "/g/steinmetz/wmueller/NGLY1"
sampleAnnot = read.delim(file=file.path(folder, "samples-CP4.txt"), stringsAsFactors=FALSE, check.names=FALSE)

jobsHasFinished = file.exists(file.path(folder, "alignments/CP4", sampleAnnot$name, "accepted_hits.bam"))

outfolder = file.path(folder, "alignment_filtered")
if (!file.exists(outfolder))  dir.create(outfolder)


run_samtools_filter_by_mapping_quality = function(x, mq,o,ncpu){
    cmd = paste("samtools view", 
        "-@", ncpu, 
        "-q", mq,
        "-b",x, ">", o)
    cat(cmd, "\n")
    system(cmd)
}

f = factor(with(sampleAnnot[jobsHasFinished,], paste(individual,treatment,  biorep, sep="_")))
tmplst = split(sampleAnnot[jobsHasFinished,],f)

## careful here if one samples doesn't have multiple technical replicates, since samtools merge needs multiple inputs 
## you need to do it manually, in my case it was only 1 
for(i in 1:length(tmplst)){
    tmpfolder = file.path(folder, "tmp")
    if (!file.exists(tmpfolder))  dir.create(tmpfolder)
    
    cat("\n",names(tmplst)[i],"\n\n")
    thisChunk = tmplst[[i]]
    for(j in 1:nrow(thisChunk)) {
        run_samtools_filter_by_mapping_quality(
            file.path(folder,"alignments", thisChunk$name[j], "accepted_hits.bam"), 
            30, 
            file.path(tmpfolder,paste0(with(thisChunk[j,], paste(individual, treatment, biorep, techrep,sep="_")), ".bam")),
            10
            )
    }
    
    cmd = paste(
        "samtools merge -r -@ 10 -1", file.path(outfolder, paste0(names(tmplst)[i], ".bam")),
        paste(dir(tmpfolder, full.names=TRUE), collapse=" "))
    cat(cmd, "\n")    
    system(cmd)
    unlink(tmpfolder,recursive = TRUE)    
}
