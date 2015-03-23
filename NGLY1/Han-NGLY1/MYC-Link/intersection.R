myc=read.table('MYC-partners',header=F)
six = read.table('DE_treatment_six_samples.txt', header=F)
four = read.table('DE_treatment_four_patients.txt', header=F)
myc_six=intersect(myc[,1],six[,2])
myc_four=intersect(myc[,1],four[,2])

myc_six_id = six[six[,2] %in% myc_six,1:2]
myc_four_id = four[four[,2] %in% myc_four,1:2]

write.table(myc_six_id, 'DE_six_samples_MYC.txt',quote=F,col.names=F, row.names=F)
write.table(myc_four_id, 'DE_four_samples_MYC.txt',quote=F,col.names=F, row.names=F)



