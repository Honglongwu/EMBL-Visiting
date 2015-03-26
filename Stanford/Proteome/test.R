pep = read.table('ch_Mar2015_NGLY1-BCells_HpH_Rep1-2_peptides.txt', sep='\t', comment.char="",header=T)
grep('sp',pep$Protein.Group.Accessions)
pep<-subset(pep, !grepl('sp',pep$Protein.Group.Accessions))
pep.s<-pep[,c(1:3,5:8,15:16,22:27,33)]
pro.names<-as.character(pep.s[,6])
pro.names.parse<-sapply(strsplit(pro.names, '-'), '[', 1)
pep.s$Protein.Group.Accessions<-pro.names.parse
pro.names<-as.character(pep.s[,6])
pro.names.parse<-sapply(strsplit(pro.names, ';'), '[', 1)
pep.s$Protein.Group.Accessions<-pro.names.parse
pep.s<-subset(pep.s, X..Protein.Groups==1)
pep.s$numNA<-rowSums(is.na(pep.s[,c(10:13)]))
pep.s<-subset(pep.s, numNA<3)
