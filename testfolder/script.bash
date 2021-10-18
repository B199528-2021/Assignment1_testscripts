# add shebang line
#!/bin/bash

# create a variable for the fastq file to be analysed
FQFILE="100k.C1-1-501_1"

# create a folder for the output files
mkdir fastqc_out_folder .

# create a file for the fastqc summaries
echo "This is an overview of all fastqc summary files." > summaries_fastqc.txt


# run the software fastqc
# save the output in the folder "fastqc_out_folder"
fastqc -o fastqc_out_folder ~/data_assessment1/$FQFILE.fq.gz

# go to the output folder
cd fastqc_out_folder

# open the zip file in the output folder
unzip "*.zip"

# go to the unzipped folder
cd ${FQFILE}_fastqc

# save the summary into a file and tell the user
cat summary.txt >> ../../summaries_fastqc.txt
echo -e "\nPlease find the summary of fastqc quality check in the file 'summaries_fastqc'."
echo "If the sequence failed the check, it might be a good idea to trim low quality reads and adapters."
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
