# add shebang line
#!/bin/bash

echo "Calculating the average was not successful."

exit

echo "Calculating the average now ..."

rm -r analysis
mkdir analysis

while read ONEGROUP
do

 cp ./bedtoolsoutput/bedtoolsoutput.$ONEGROUP.tsv ./bedtoolsoutput/averagecounts.$ONEGROUP.tsv

 # delete the first columns (gene + description)
 cut -f -2 ./bedtoolsoutput/averagecounts.$ONEGROUP.tsv > tempfile

 # THE OUTPUT IS NOT THE AVERAGE - SOMETHING WENT WRONG:
 # calculate average
 awk '{FS="\t"; OFS="\t"; s=0; for (i=1;i<=NF;i++)s+=$i; print s/NF;}' tempfile > ./bedtoolsoutput/averagecounts.$ONEGROUP.tsv
 rm tempfile

 # join the columns
 cut -f -2 ./bedtoolsoutput/bedtoolsoutput.$ONEGROUP.tsv | paste ./bedtoolsoutput/averagecounts.$ONEGROUP.tsv - > temp
 mv temp ./analysis/$ONEGROUP.tsv

 rm ./bedtoolsoutput/averagecounts.$ONEGROUP.tsv

 echo "Average for $ONEGROUP calculated."

done < ./groups.txt

echo "Please find the average results in the folder 'analysis'."


# add two columns in one file
cd ./analysis

SAMPLE="Clone1"
TIME="24"
REF="Uninduced"
EXP="Induced"

# take only first column
cut -f1 $SAMPLE.$TIME.$REF.tsv > refcolumn
# put first column to beginning of other 3 columns
cut -f -3 $SAMPLE.$TIME.$EXP.tsv | paste refcolumn - > temporaer
mv temporaer compare.$SAMPLE.$TIME.$REF-$EXP.tsv
rm refcolumn


# calculate fold change
awk '$2 !=0 || $1 !=0{ print $2/$1 }' compare.$SAMPLE.$TIME.$REF-$EXP.tsv > fold.$SAMPLE.$TIME.$REF-$EXP.tsv
exit


# join the columns
# delete the first columns (gene + description)
cut -f -2 ..tsv > tempfile
cut -f 3 $SAMPLE.$TIME.Uninduced.tsv | paste $SAMPLE.$TIME.Induced.tsv - > temptest
mv temptest compare.$SAMPLE.$TIME.Uninduced-Induced.tsv


for i in Clone1.24.*.tsv
do
  for j in Clone1.24.*.tsv
  do
    if [ "$i" \< "$j" ]
    then
     echo "Pairs $i and $j"
    fi
  done
done

cd ..
echo "FINISHED"
