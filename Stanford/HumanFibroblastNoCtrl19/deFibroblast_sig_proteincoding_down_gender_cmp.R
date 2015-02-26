x=read.table('deFibroblast_sig_proteincoding_down.txt')
dim(x)[1]
y=read.table('deFibroblast_sig_proteincoding_down.nogender.txt')
dim(y)[1]
intersect(rownames(x), rownames(y))
