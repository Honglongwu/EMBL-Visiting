genename = 'NGLY1'
homeFolder = '/g/steinmetz/wmueller/NGLY1'
load(file.path(homeFolder, 'gtf.rda'))
proteinid = unique(mcols(gtf)[mcols(gtf)$gene_name == genename,]$protein_id)
proteinid = proteinid[!is.na(proteinid)]
proteinid = paste0('9606.', proteinid)

string = read.table('/g/steinmetz/hsun/NGLY1/Data/string/9606.protein.links.v9.1.txt', header=T)
