input = read.table('ALL-VariationTable-Homo_sapiens-Gene-Variation_Gene-73-ENSG00000151092-ENST00000280700.txt',sep='\t')
dbsnp = input[input[6] == 'dbSNP',]
cosmic = input[input[6] == 'COSMIC',]
