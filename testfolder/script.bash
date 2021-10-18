# add shebang line
#!/bin/bash

# directory with fastq files
DIRFQFILE="/localdisk/data/BPSM/AY21/fastq"

# create a folder for the output files
rm -r fastqc_out_folder
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

exit

#----------------------------------------------------
# THIS IS ONLY FOR TESTING -> TODO: REMOVE AT THE END
# pick only the first 6 reads
sed -i -n "1,6 p" all_fastqc_files.txt
#----------------------------------------------------


# run fastqc for all fastq files
while read CHECK
do
 
 # save the output in the folder "fastqc_out_folder"
 fastqc -o fastqc_out_folder $DIRFQFILE/$CHECK
 
done < all_fastqc_files.txt

# unzip the zip file
#cd fastqc_out_folder
#unzip "*.zip"



exit

# test:

# create a variable for the fastq file to be analysed
FQFILE="100k.C1-1-501_1"

# go to the unzipped folder
cd ${FQFILE}_fastqc

# save the summary into a file and tell the user
cat summary.txt >> ../../summaries_fastqc.txt
echo -e "\nPlease find the summary of fastqc quality check in the file 'summaries_fastqc'."
echo "You can also find the html files for each sequence in the folder 'fastqc_out_folder'."
echo -e "\nIf the sequence failed the check, it might be a good idea to trim low quality reads and adapters."
echo "You could run for example 'TrimGalore' to get better qualities of your sequences."
echo "If you want to exclude sequences, please delete them from your folder and run this script again."

# ask user if he wants to stop
echo -e "\nDo you want to continue without excluding any sequences? [Y,n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then
	echo "This script continues now."
else
	echo "Please exclude your sequences and then run this script again."
	exit
fi

echo "test if it continues"
