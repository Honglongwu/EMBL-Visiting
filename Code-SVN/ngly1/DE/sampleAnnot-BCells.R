## form the sample annotation
folder = "/g/steinmetz/wmueller/NGLY1/"

load(file.path(folder, "counts-BCells.rda"))

sampleAnnot = unique(pd[,c("individual", "biorep", "label")])
sampleAnnot$sampleStatus = sampleStatus = factor(c(rep("patient", 4), rep("control", 4)))
sampleAnnot$individual = relevel(factor(sampleAnnot$individual), "MCP1-B")
sampleAnnot$gender = factor(c("female","female","male","male","NA","NA","female","female"))    
save(sampleAnnot, file=file.path(folder, "sampleAnnot-BCells.rda"))
