# add shebang line
#!/bin/bash

# path of the bedfile
BEDFILE="/localdisk/data/BPSM/AY21/TriTrypDB-46_TcongolenseIL3000_2019.bed"

# put all the bam files into a variable
while read SEQ
do
 echo "./bowtieoutput/$SEQ.bam" >> tempfile
 done < ./all_fastqc_files_unique.txt

# delete newlines
tr "\n" " " < tempfile > tempfile2
rm tempfile
rm bamfiles.txt
mv tempfile2 bamfiles.txt

# save it into a variable
BAMFILES=$(<bamfiles.txt)




echo $BAMFILES




echo "FINISHED"
