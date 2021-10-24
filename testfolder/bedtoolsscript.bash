# add shebang line
#!/bin/bash

# path of the bedfile
BEDFILE="/localdisk/data/BPSM/AY21/TriTrypDB-46_TcongolenseIL3000_2019.bed"

echo "Please wait, bedtools is running ..."


# run bedtools for one group only

# find out the groups

# copy the columns of sample details file into a new file sample_details.tsv
cp /localdisk/data/BPSM/AY21/fastq/100k.fqfiles ./sample_details.tsv

# delete irrelevant columns
awk '{$6=$7=""; print $0}' sample_details.tsv > tempfile
mv tempfile sample_details.tsv

# TODO: loop

# for loop iterating through sample details lines

# number of lines in sample details
NR=`wc -l sample_details.tsv | awk '{ print $1-1}'`

i=0
for f in $(seq 1 $NR)
do
 i=$(( i + 1 ))
 echo index $i
done

exit


# save columns for groups into variable
LINE=$(awk '{if(NR==4) print $2,$4,$5;}' sample_details.tsv)

# replace spaces by dots
GROUP=$(echo "$LINE" | tr " " .)

echo "test $GROUP"

awk -v username="$GROUP" -v line=4 'NR == line { $0 = $0 username } 1' sample_details.tsv




exit

for var in a b c d e
do
 echo -e

exit



### OLD VERSION:

# put all the bam files into a variable
while read SEQ
do
 echo "./bowtieoutput/$SEQ.bam" >> tempfile
done < ./all_fastqc_files_unique.txt

# delete newlines
tr "\n" " " < tempfile > tempfile2
rm tempfile
mv tempfile2 bamfiles.txt

# save it into a variable
BAMFILES=$(<bamfiles.txt)

# run bedtolls for all bam alignments
bedtools multicov -bams $BAMFILES -bed $BEDFILE > bedtoolsoutput.txt

# delete bamfiles.txt
rm bamfiles.txt

# create a file without chromosome details
cut -f 4- bedtoolsoutput.txt > bedtoolsoutput_genes.tsv

# add a header

# delete the "100k." from the fq files
while read FQ
do
 echo $FQ | cut -c 6-13 >> tmpfile
done < all_fastqc_files.txt

mv tmpfile all_fastqc_files_without_100k.txt



exit


VARIABLE=$(for  in ...; do ...; done)

echo "FINISHED"


# put them into a variable
while read SEQ
do
 echo "$SEQ" >> tempfile
done < ./all_fastqc_files_without_100k.txt

# delete newlines
tr "\n" " " < tempfile > tempfile2
rm tempfile
mv tempfile2 spacefiles.txt



# save it into a variable
#TABFILES = $(<tabfiles.txt)


# copy for testing
cp bedtoolsoutput_genes.tsv testgenes.tsv

# add header to bedtoolsoutput_genes.tsv
#sed  -i '1i $TABFILES' testgenes.tsv

echo "Bedtools finished. Please find the results in the file 'bedtoolsoutput_genes.tsv'."

