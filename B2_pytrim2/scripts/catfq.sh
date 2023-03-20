#!/bin/bash

INPATH=$1

cd $INPATH

FILES="*.fastq"
for f in $FILES
do
  echo "Concatenating $f file..."
  # take action on each file. $f store current file name
  cat "$f" >> ./all.fastq
done

exit
