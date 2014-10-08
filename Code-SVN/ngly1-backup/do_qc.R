# run QC use fastqc tools on each of the raw seq files
# Author: czhu
###############################################################################
run_QC = function(x,o, ncpu=10){
    f = paste(x, collapse=" ")
    cmd = paste("fastqc -o", o , "--threads", ncpu, f)
    system(cmd)
}

folder = "/g/steinmetz/wmueller/NGLY1"

seqFolders = c("/g/steinmetz/incoming/solexa/2014-09-05-C532NACXX")

infiles = unlist(lapply(seqFolders, dir,pattern="sequence.txt.gz",full.names=TRUE))
infiles = infiles[!grepl("PhiX", infiles)]

outfolder = file.path(folder, "QC-BCells")
if (!file.exists(outfolder))  dir.create(outfolder)

run_QC(infiles, outfolder)
