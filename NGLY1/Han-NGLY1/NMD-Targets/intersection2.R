x = read.table('upf_drug_effect_atleastwo.txt')[,1]
y = read.table('upf_drug_effect_atleasttwo_id.txt')[,2]
table(y)[table(y)>1]


x = read.table('upf_drug_effect_six_samples.txt')[,1]
y = read.table('upf_drug_effect_four_patients.txt')[,1]
