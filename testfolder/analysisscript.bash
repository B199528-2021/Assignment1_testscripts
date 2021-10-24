# add shebang line
#!/bin/bash

echo "Calculating the average now ..."


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



