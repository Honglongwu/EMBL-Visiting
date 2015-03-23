myc=read.table('MYC-partners',header=F)
six = read.table('DE_CP1_4_MFCP1_19_unique.txt', header=F)
myc_six=intersect(myc[,1],six[,1])

write.table(myc_six, 'de_any_six_samples_MYC.txt',quote=F,col.names=F, row.names=F)



