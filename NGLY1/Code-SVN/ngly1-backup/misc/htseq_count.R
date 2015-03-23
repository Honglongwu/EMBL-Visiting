# TODO: Add comment
# 
# Author: czhu
###############################################################################

folder ="/g/steinmetz/wmueller/NGLY1/"
outfolder = file.path(folder, "countFiles")

infolder = file.path(folder, "alignment_filtered/")
infiles = dir(infolder, "*bam$",full.names=TRUE)

library(doMC)
registerDoMC(cores=10)
foreach(f=iter(infiles)) %dopar% {
    cmd = paste("samtools view", f ,
        "| python2.7 /g/steinmetz/czhu/sw/lib64/R/library/DEXSeq/python_scripts/dexseq_count.py -s no /g/steinmetz/wmueller/NGLY1//genome/Homo_sapiens.GRCh37.68.DEXseq.gtf -", 
        file.path(outfolder, sub("\\..*", "", basename(f)))
    )
    cat(cmd, "\n")
    system(cmd)
}


