# get the relevant factors from the sample annotation table
# Author: czhu
###############################################################################

folder = "/g/steinmetz/wmueller/NGLY1"
sampleAnnot = read.delim(file=file.path(folder, "sampleAnnot-BCells.txt"), stringsAsFactors=FALSE, check.names=FALSE)


#tmpstr = sub("ngly1_(.*?)_(.*)_rep(\\d)_lane(\\d+)","\\1\t\\2\tbiorep\\3\ttechrep\\4",sampleAnnot$fixedName)
tmpstr = sub("ngly1_(.*?)_(\\d)_lane(\\d+)","\\1\tbiorep\\2\ttechrep\\3",sampleAnnot$name)
annot =do.call(rbind, strsplit(tmpstr, "\t"))
colnames(annot) = c("individual", "biorep", "techrep")
#annot[,"treatment"] = sub("20uM_AzaC","AzaC_20uM",annot[, "treatment"])

newAnnot=cbind(sampleAnnot, annot)

#newAnnot$label = with(newAnnot,paste(individual, treatment, biorep,sep="_"))
newAnnot$label = with(newAnnot,paste(individual, biorep,sep="_"))
newAnnot= newAnnot[order(newAnnot$label, newAnnot$techrep),]
write.table( newAnnot, file=file.path(folder, "samples-BCells.txt"), quote = FALSE, sep = "\t",  row.names = FALSE)
