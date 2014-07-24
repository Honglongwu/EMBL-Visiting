## form the sample annotation
folder = "/g/steinmetz/wmueller/NGLY1/"

load(file.path(folder, "counts-CP4.rda"))

sampleAnnot = unique(pd[,c("individual", "treatment", "biorep", "label")])
sampleAnnot$treatment = factor(sampleAnnot$treatment, levels=c("DMSO", "AzaC_20uM"))
sampleAnnot$sampleStatus = factor(c(rep("control", 4), rep("patient", 16), rep("control", 8)), levels=c("control", "patient"))
sampleAnnot$sampleOrigin = factor(rep(c("cellLine", "patientDerived"), c(4, 24)), levels=c("cellLine", "patientDerived"))
sampleAnnot$family = factor(c(rep("non-w", 4),rep("w", 4), rep("non-w", 12), rep("w", 8)), levels=c("non-w","w"))
sampleAnnot$individual = relevel(factor(sampleAnnot$individual), "MCP1")
sampleAnnot$gender = factor(ifelse(sampleAnnot$individual %in% c("FCP1","CP2","CP3"), "male", "female"), levels=c("female","male"))
    
save(sampleAnnot, file=file.path(folder, "sampleAnnot-CP4.rda"))
