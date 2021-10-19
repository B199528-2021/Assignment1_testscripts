# add shebang line
#!/bin/bash

# path of the bedfile
BEDFILE="/localdisk/data/BPSM/AY21/TriTrypDB-46_TcongolenseIL3000_2019.bed"

# convert bam alignments to BED formats
for x in ./bowtieoutput/*.bam
do
 bedtools bamtobed -i "$x" > "${x%.bam}.bed"
done
echo "finished"
