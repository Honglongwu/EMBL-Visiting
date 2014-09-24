D = {}
inFile = open("nationwidechildrens.org_clinical_patient_ucec.txt")
head = inFile.readline()
head = inFile.readline()
head = inFile.readline()

for line in inFile:
    line = line.strip()
    fields = line.split("\t")
    if len(fields) > 1:
        sample = fields[0]
        D[sample] = 1
inFile.close()

print(len(D))
