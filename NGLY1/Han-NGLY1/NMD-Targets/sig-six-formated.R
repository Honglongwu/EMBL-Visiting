data = load('DESeq-treatment-control-pairwise.rda')
sig.gene.six = read.table('DE_treatment_six_samples.txt')[,1]
get.sig = function(x)
{
    x[rownames(x) %in% sig.gene.six,]


}
