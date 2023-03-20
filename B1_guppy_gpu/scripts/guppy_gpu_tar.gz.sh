#!/bin/bash

GUPPYCFG=$1


## Untar and decompress fast5 files to /mnt/data/tmp/
print "Creating directories for fast5 files and reports..."
mkdir -p /mnt/data/tmp/
mkdir -p /mnt/data/tmp_fast5/
mkdir -p /mnt/data/reports/

print "Start decompressing fast5 files..."
tar -xzvf /mnt/data/*.tar.gz -C /mnt/data/tmp/

print "Sort files into appropriate folders..."
find /mnt/data/ -iname *.pdf -exec mv {} /mnt/data/reports/ \;
find /mnt/data/ -iname *.html -exec mv {} /mnt/data/reports/ \;
find /mnt/data/ -iname *.fast5 -exec mv {} /mnt/data/tmp_fast5/ \;

print "Create folder for bascalled files"
mkdir -p /mnt/data/basecalled/


## Run the basecaller
print "Running basecaller..."
guppy_basecaller -i /mnt/data/tmp_fast5/ -s /mnt/data/basecalled/ -c $GUPPYCFG --do_read_splitting -x "cuda:0"


## Remove the unzipped fast5 files
print "Removing tmp_fast5 folder"
rm -r /mnt/data/tmp_fast5/
