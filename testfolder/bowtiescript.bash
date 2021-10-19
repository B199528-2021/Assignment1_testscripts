# add shebang line
#!/bin/bash

# directory with reference genome sequence of Trypanosama congolense
DIRTCONGO="/localdisk/data/BPSM/AY21/Tcongo_genome/"

# directory with fastq files
DIRFQFILE="/localdisk/data/BPSM/AY21/fastq"

#=============================================
# TODO: activate (uncomment) at the end!!!
## copy genome sequence into a folder and unzip it to have a fasta file
#rm -r reference_genome
#cp -r $DIRTCONGO reference_genome
#gunzip ./reference_genome/*.gz
#
## create an index for the reference genome
## references: http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml#obtaining-bowtie-2
## references: https://www.youtube.com/watch?v=fSnAeYHnPCw
#cd ./reference_genome
#bowtie2-build ./*fasta Tcongolense
#
#cd ..
#
#
## extract fastq files from localdesk (DIRFQFILE="/localdisk/data/BPSM/AY21/fastq")
#echo "Please wait, file being extracted..."
#rm -r fastq_extracted_files
#cp -r $DIRFQFILE fastq_extracted_files
#gunzip ./fastq_extracted_files/*.fq.gz
#
#
## pick read1 and read2 for running bowtie2
#
## delete the file endings ("_1" or "_2") in the file "all_fastqc_files.txt"
#while read LINE
#do
# echo $LINE | rev | cut -c3- | rev >> tmpfile
#done < all_fastqc_files.txt
#mv tmpfile all_fastqc_files.txt 
#
#
## delete the duplicates
#uniq all_fastqc_files.txt > tmpfile
#mv tmpfile all_fastqc_files.txt
#
#=============================================

rm -r bowtieoutput
mkdir bowtieoutput
echo "Please wait, bowtie2 is running ..."
# go to reference_genome file
cd ./reference_genome
DIR="../fastq_extracted_files/"
while read SEQ
do
 bowtie2 -x Tcongolense -1 ${DIR}/${SEQ}_1.fq -2 ${DIR}/${SEQ}_2.fq -S ../bowtieoutput/${SEQ}.sam
done < ../all_fastqc_files.txt



# find out directory
echo "Here I am now:"
pwd
