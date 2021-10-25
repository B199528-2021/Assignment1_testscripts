# add shebang line
#!/bin/bash

echo "Calculating the average now ..."

rm -r analysis
mkdir analysis

while read ONEGROUP
do

 cp ./bedtoolsoutput/bedtoolsoutput.$ONEGROUP.tsv ./bedtoolsoutput/averagecounts.$ONEGROUP.tsv

 # delete the first columns (gene + description)
 cut -f -2 ./bedtoolsoutput/averagecounts.$ONEGROUP.tsv > tempfile

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



# test

cd ./analysis

SAMPLE="Clone1"
TIME="24"
cut -d " " -f3 $SAMPLE.$TIME.Induced.tsv > short

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
