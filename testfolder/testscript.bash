# add shebang line
#!/bin/bash

# create a variable for the fastq file to be analysed
FQFILE="100k.C1-1-501_1"

# run the software fastqc
# save the output in the folder "fastqc_out_folder"
fastqc -o fastqc_out_folder ~/data_assessment1/$FQFILE.fq.gz

# go to the output folder
cd fastqc_out_folder

# open the zip file in the output folder
unzip "*.zip"

# go to the unzipped folder
cd ${FQFILE}_fastqc

# show the summary file
cat summary.txt
