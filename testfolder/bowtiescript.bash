# add shebang line
#!/bin/bash

# directory with reference genome sequence of Trypanosama congolense
DIRTCONGO="/localdisk/data/BPSM/AY21/Tcongo_genome/"

# directory with fastq files
DIRFQFILE="/localdisk/data/BPSM/AY21/fastq"

# delete folders and directories in case they alredy exist
rm -r fastq_extracted_files
rm -r reference_genome

# copy genome sequence into a folder and unzip it to have a fasta file
cp -r $DIRTCONGO reference_genome
gunzip ./reference_genome/*.gz

# create an index for the reference genome
# references: http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml#obtaining-bowtie-2
# references: https://www.youtube.com/watch?v=fSnAeYHnPCw
cd ./reference_genome
bowtie2-build ./*fasta Tcongolense





# find out directory
echo "Here I am:"
pwd
