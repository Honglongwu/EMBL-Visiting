import subprocess
ouFile = open('test-out', 'w')
sp = subprocess.Popen(['samtools', 'view', 'unmapped.bam'], stdout=subprocess.PIPE)
for  x in sp.stdout:
    fields = x.split('\t')
    ouFile.write(fields[9]+'\n')
ouFile.close()
