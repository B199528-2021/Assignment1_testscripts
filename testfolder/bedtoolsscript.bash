# add shebang line
#!/bin/bash

# path of the bedfile
BEDFILE="/localdisk/data/BPSM/AY21/TriTrypDB-46_TcongolenseIL3000_2019.bed"

echo "Please wait, generating groups ..."


# run bedtools for one group only

# find out the groups

# copy the columns of sample details file into a new file sample_details.tsv
cp /localdisk/data/BPSM/AY21/fastq/100k.fqfiles ./sample_details.tsv

# delete irrelevant columns
awk '{$6=$7=""; print $0}' sample_details.tsv > tempfile
mv tempfile sample_details.tsv


# for loop iterating through sample details lines

# number of lines in sample details
LINENR=`wc -l sample_details.tsv | awk '{ print $1}'`

cp sample_details.tsv test

# indexing lines
INDEX=0
for SAMPLE in $(seq 1 $LINENR)
do
 INDEX=$(( INDEX + 1 ))
 LINE=$(awk -v linenumber="$SAMPLE" '{if(NR==linenumber) print $2,$4,$5;}' sample_details.tsv)
 GROUP=$(echo "$LINE" | tr " " .)
 awk -v username="$GROUP" -v line="$SAMPLE" 'NR == line { $0 = $0 username } 1' sample_details.tsv > test
 grep "$GROUP" test >> tester
done

rm test

# overwrite sample_details.tsv
mv tester sample_details.tsv

# find out groups
awk '{print $6}' sample_details.tsv > groups.txt
# delete header
sed 1d groups.txt > temp
mv temp groups.txt
# delete duplicates
cat groups.txt | sort | uniq > temp
mv temp groups.txt


# groups.txt will be important for the loop for bedtools


#---

# test for "Clone1.48.Induced" only

# save the 1st column where the group is "Clone1.48.Induced"
awk '{if($6 == "Clone1.48.Induced"){print $1;}}' sample_details.tsv > onegroup.txt

# add "100k." to each line
sed -i -e 's/^/100k./' onegroup.txt 

# put all the bam files into a variable
while read SEQ
do
 echo "./bowtieoutput/$SEQ.bam" >> tempfile
done < ./onegroup.txt

# delete newlines
tr "\n" " " < tempfile > tempfile2
rm tempfile
mv tempfile2 bamfiles.txt

# save it into a variable
BAMFILES=$(<bamfiles.txt)

# run bedtools for all bam alignments
bedtools multicov -bams $BAMFILES -bed $BEDFILE > bedtoolsoutput.txt

# create a file without chromosome details
cut -f 4- bedtoolsoutput.txt > bedtoolsoutput_genes.tsv

# delete bamfiles.txt
rm bamfiles.txt

echo "This is a test for 'Clone1.48.Induced' only."

exit



# TODO next: loop!

while read GROUP
do
 
 # save the first column from this group
 awk -v groupname="$GROUP" '{if($6 == groupname){print $1;}}' sample_details.tsv > onegroup.txt
 
 # add "100k." to each line
 sed -i -e 's/^/100k./' onegroup.txt

 # put all the bam files into a variable
 while read SEQ
 do
  echo "./bowtieoutput/$SEQ.bam" >> tempfile
 done < ./onegroup.txt

 # delete newlines
 tr "\n" " " < tempfile > tempfile2
 rm tempfile
 mv tempfile2 bamfiles.txt

 # save it into a variable
 BAMFILES=$(<bamfiles.txt)

 # run bedtools for all bam alignments
 bedtools multicov -bams $BAMFILES -bed $BEDFILE > bedtoolsoutput.txt

 # create a file without chromosome details
 cut -f 4- bedtoolsoutput.txt > bedtoolsoutput_genes.tsv

 # delete bamfiles.txt
 rm bamfiles.txt

 # save file in group specific file
 mv bedtoolsoutput_genes.tsv bedtoolsoutput.$GROUP.tsv

done < ./groups.txt

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

