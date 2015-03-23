folder = "/tmpdata/czhu/GEUV"
dat = read.delim(file=file.path(folder, "E-GEUV-1.sdrf.txt"), stringsAsFactors=FALSE, check.names=FALSE)

subdat = unique(dat[, c("Source Name", "Characteristics[population]")])

selSamples = unlist(tapply(subdat[, "Source Name"], subdat[, "Characteristics[population]"], sample,size=8))

library(doMC)
registerDoMC(cores=10)
foreach(thisSample=iter(selSamples)) %dopar% {
    thislink = unique(dat[which(thisSample ==dat[, c("Source Name")]),"Comment [Derived ArrayExpress FTP file]"])
    stopifnot(length(thislink)  ==1)
    newlink = sub("ftp://ftp.ebi.ac.uk/pub/databases/microarray/data/experiment/GEUV/", "http://www.ebi.ac.uk/arrayexpress/files/", thislink)
    download.file(newlink, destfile=file.path(folder, basename(newlink)))
}



