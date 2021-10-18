# add shebang line
#!/bin/bash

# directory with fastq files
DIRFQFILE="/localdisk/data/BPSM/AY21/fastq"

# delete folders and directories in case they alredy exist
rm -r fastqc_out_folder
rm all_fastqc_files.txt
rm summaries_fastqc.txt

# create a folder for the output files
mkdir fastqc_out_folder

# create a file for the fastqc summaries
echo "This is an overview of all fastqc summary files." > summaries_fastqc.txt

# save all the fastq file names in a text file
for FQ in $DIRFQFILE
do
 ls $FQ > all_fastqc_files.txt
done

# include only files which end with ".fq.gz"
grep ".fq.gz" all_fastqc_files.txt > tmpfile && mv tmpfile all_fastqc_files.txt

# delete the file endings
while read FQ
do
 echo $FQ | rev | cut -c7- | rev >> tmpfile
done < all_fastqc_files.txt

mv tmpfile all_fastqc_files.txt


#----------------------------------------------------
# THIS IS ONLY FOR TESTING -> TODO: REMOVE AT THE END
# pick only the first 2 reads
sed -i -n "1,2 p" all_fastqc_files.txt
#----------------------------------------------------


# run fastqc for all fastq files
while read CHECK
do
 # save the output in the folder "fastqc_out_folder"
 fastqc -o fastqc_out_folder $DIRFQFILE/$CHECK.fq.gz
done < all_fastqc_files.txt

# unzip the zip file
cd fastqc_out_folder
unzip "*.zip"

cd ..

# save the fastqc summaries into one file
while read READS
do
 cd ./fastqc_out_folder/${READS}_fastqc
 cat summary.txt >> ../../summaries_fastqc.txt
 cd ../..
done < all_fastqc_files.txt

# let the user know
echo -e "\nPlease find the summary of fastqc quality check in the file 'summaries_fastqc'."
echo "You can also find the html files for each sequence in the folder 'fastqc_out_folder'."
echo -e "\nIf the sequence failed the check, it might be a good idea to trim low quality reads and adapters."
echo "You could run for example 'TrimGalore' to get better qualities of your sequences."
echo "If you want to exclude sequences, please delete them from your folder and run this script again."

# ask user if he wants to stop
echo -e "\nIS IT OKAY TO CONTINUE WITH THE CURRENT SEQUENCE? (default is 'Y')"
echo "Type in 'N' if you want to exclude sequences from your folder instead."

read -n1 -p "Is it okay? [y,n]" doit 
case $doit in  
  y|Y) echo " This script continues now." ;; 
  n|N) echo " You decided to exclude your sequences first and then run this script again." ; exit ;; 
  *) echo " This script continues now." ;; 
esac

# directory with reference genome sequence of Trypanosoma congolense
DIRTCONGO="/localdisk/data/BPSM/AY21/Tcongo_genome/"

# copy genome sequence into a folder and ungzip it
cp -r $DIRTCONGO Tcongo_genome
cd Tcongo_genome
gunzip *.gz




