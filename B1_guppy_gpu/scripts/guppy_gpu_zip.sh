#!/bin/bash

GUPPYCFG=$1


## Unzip fast5 files to /mnt/data/tmp/
mkdir -p /mnt/data/tmp/
mkdir -p /mnt/data/tmp_fast5/
mkdir -p /mnt/data/reports/
unzip /mnt/data/*.zip -d /mnt/data/tmp/
find /mnt/data/tmp/ -iname *.pdf -exec mv {} /mnt/data/reports/ \;
find /mnt/data/tmp/ -iname *.html -exec mv {} /mnt/data/reports/ \;
find /mnt/data/tmp/ -iname *.fast5 -exec mv {} /mnt/data/tmp_fast5/ \;
rm -r /mnt/data/tmp/
mkdir -p /mnt/data/basecalled/


## Run the basecaller
guppy_basecaller -i /mnt/data/tmp_fast5/ -s /mnt/data/basecalled/ -c $GUPPYCFG --do_read_splitting -x "cuda:0"


## Remove the unzipped fast5 files
rm -r /mnt/data/tmp_fast5/
