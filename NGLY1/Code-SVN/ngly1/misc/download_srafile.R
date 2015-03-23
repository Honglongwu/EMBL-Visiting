## download SRA files for age related samples
library(SRAdb)
sqlfile = "/g/steinmetz/wmueller/NGLY1/SRA/SRAmetadb.sqlite"

if(!file.exists(sqlfile)) {
    sqlfile <- getSRAdbFile(dirname(sqlfile), basename(sqlfile))
} 

sra_con <- dbConnect(SQLite(),sqlfile)
samples = c("SRS210930", "SRS211008", "DRS008180", "DRS007931")
getSRAfile( samples, sra_con=sra_con,fileType="fastq")
