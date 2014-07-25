library(GenomicAlignments)

Score = 700
homeFolder = '/g/steinmetz/wmueller/NGLY1'
STRING = '/g/steinmetz/hsun/NGLY1/Data/string/9606.protein.links.v9.1.txt'


interaction = function(genename)
{
load(file.path(homeFolder, 'gtf.rda'))
proteinid = unique(mcols(gtf)[mcols(gtf)$gene_name == genename,]$protein_id)
proteinid = proteinid[!is.na(proteinid)]
proteinid = paste0('9606.', proteinid)

string = read.table(STRING, header=T)
s = string[string$protein1 %in% proteinid & string$combined_score >= Score,]
partner = unique(mcols(gtf)[paste0('9606.',mcols(gtf)$protein_id) %in% s$protein2,]$gene_name)
partner = union(genename,partner)
write.table(partner,paste0(genename,'-partners'),quote=F,row.names=F,col.names=F)
}

interaction('NGLY1')
interaction('SRSF2')
interaction('MYC')
interaction('TP53')
