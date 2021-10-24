# add shebang line
#!/bin/bash

echo "Calculating the average now ..."


while read ONEGROUP
do

 cp ./bedtoolsoutput/bedtoolsoutput.$ONEGROUP.tsv ./bedtoolsoutput/averagecounts.$ONEGROUP.tsv

 # delete the first columns (gene + description)
 cut -f -2 ./bedtoolsoutput/averagecounts.$ONEGROUP.tsv > tempfile

 # calculate average
 awk '{s=0; for (i=1;i<=NF;i++)s+=$i; print s/NF;}' tempfile > ./bedtoolsoutput/averagecounts.$ONEGROUP.tsv
 rm tempfile

 # join the columns
 cut -f -2 ./bedtoolsoutput/bedtoolsoutput.$ONEGROUP.tsv | paste ./bedtoolsoutput/averagecounts.$ONEGROUP.tsv - > temp
 mv temp ./bedtoolsoutput/average.$ONEGROUP.tsv

 rm ./bedtoolsoutput/averagecounts.$ONEGROUP.tsv

 echo "Average for $ONEGROUP calculated."

done < ./groups.txt

echo "Please find the average results in the folder 'bedtoolsoutput'."

echo "This is the current directory:"
pwd

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
awk '{s=0; for (i=1;i<=NF;i++)s+=$i; print s/NF;}' tempfile > ./averagecounts.$ONEGROUP.tsv





echo "This is the current directory:"
pwd



