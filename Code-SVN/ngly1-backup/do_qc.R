# run QC use fastqc tools on each of the raw seq files
# Author: czhu
###############################################################################
run_QC = function(x,o, ncpu=10){
    f = paste(x, collapse=" ")
    cmd = paste("fastqc -o", o , "--threads", ncpu, f)
    system(cmd)
}

folder = "/g/steinmetz/wmueller/NGLY1"

seqFolders = c("/g/steinmetz/incoming/solexa/2014-05-26-C3PJ9ACXX",
    "/g/steinmetz/incoming/solexa/2014-03-25-C365AACXX",
    "/g/steinmetz/incoming/solexa/2014-05-23-C3PJ2ACXX")

infiles = unlist(lapply(seqFolders, dir,pattern="sequence.txt.gz",full.names=TRUE))
infiles = infiles[!grepl("PhiX", infiles)]

outfolder = file.path(folder, "QC")
if (!file.exists(outfolder))  dir.create(outfolder)

run_QC(infiles, outfolder)