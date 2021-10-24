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

rm -r bedtoolsoutput
mkdir bedtoolsoutput

echo "Please wait, bedtools is running ..."

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
 bedtools multicov -bams $BAMFILES -bed $BEDFILE > ./bedtoolsoutput.txt

 # create a file without chromosome details
 cut -f 4- bedtoolsoutput.txt > bedtoolsoutput_genes.tsv

 # delete bamfiles.txt
 rm bamfiles.txt

 # save file in group specific file
 mv bedtoolsoutput_genes.tsv ./bedtoolsoutput/bedtoolsoutput.$GROUP.tsv

 echo "Bedtools for $GROUP generated."

done < ./groups.txt

rm onegroup.txt
rm bedtoolsoutput.txt

echo "Please find the results for bedtools in the folder 'bedtoolsoutput'."


echo "FINISHED?"

exit


# go into the bedtoolsoutput folder
cd ./bedtoolsoutput


#-------------

# test for one group first: Clone1.0.Uninduced

ONEGROUP="Clone1.0.Uninduced"

cp bedtoolsoutput.$ONEGROUP.tsv ./averagecounts.$ONEGROUP.tsv

# delete the first columns (gene + description)
cut -f -2 averagecounts.$ONEGROUP.tsv > tempfile

# calculate average
awk '{s=0; for (i=1;i<=NF;i++)s+=$i; print s/NF;}' tempfile





echo "This is the current directory:"
pwd
