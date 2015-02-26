samtools merge -r -@ 10 -1 CP1-B_biorep1.bam /g/steinmetz/hsun/NGLY1/NGLY1-wmueller/alignment_filtered/B-Cells/CP1-B_biorep1.bam CP1-B_biorep1_lane3.bam
samtools index CP1-B_biorep1.bam
samtools merge -r -@ 10 -1 CP1-B_biorep2.bam /g/steinmetz/hsun/NGLY1/NGLY1-wmueller/alignment_filtered/B-Cells/CP1-B_biorep2.bam CP1-B_biorep2_lane3.bam
samtools index CP1-B_biorep2.bam
samtools merge -r -@ 10 -1 CP3-B_biorep1.bam /g/steinmetz/hsun/NGLY1/NGLY1-wmueller/alignment_filtered/B-Cells/CP3-B_biorep1.bam CP3-B_biorep1_lane3.bam
samtools index CP3-B_biorep1.bam
samtools merge -r -@ 10 -1 CP3-B_biorep2.bam /g/steinmetz/hsun/NGLY1/NGLY1-wmueller/alignment_filtered/B-Cells/CP3-B_biorep2.bam CP3-B_biorep2_lane3.bam
samtools index CP3-B_biorep2.bam
samtools merge -r -@ 10 -1 Ctrl-B_biorep1.bam /g/steinmetz/hsun/NGLY1/NGLY1-wmueller/alignment_filtered/B-Cells/Ctrl-B_biorep1.bam Ctrl-B_biorep1_lane3.bam
samtools index Ctrl-B_biorep1.bam
samtools merge -r -@ 10 -1 Ctrl-B_biorep2.bam /g/steinmetz/hsun/NGLY1/NGLY1-wmueller/alignment_filtered/B-Cells/Ctrl-B_biorep2.bam Ctrl-B_biorep2_lane3.bam
samtools index Ctrl-B_biorep2.bam
samtools merge -r -@ 10 -1 MCP1-B_biorep1.bam /g/steinmetz/hsun/NGLY1/NGLY1-wmueller/alignment_filtered/B-Cells/MCP1-B_biorep1.bam MCP1-B_biorep1_lane3.bam
samtools index MCP1-B_biorep1.bam
samtools merge -r -@ 10 -1 MCP1-B_biorep2.bam /g/steinmetz/hsun/NGLY1/NGLY1-wmueller/alignment_filtered/B-Cells/MCP1-B_biorep2.bam MCP1-B_biorep2_lane3.bam
samtools index MCP1-B_biorep2.bam
