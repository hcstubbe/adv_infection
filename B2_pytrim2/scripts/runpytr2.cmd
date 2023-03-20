#!/bin/bash
#SBATCH -J adv_pt2
#SBATCH -o ./seq_data/logfiles/%x.%j.%N.out
#SBATCH -e ./seq_data/logfiles/%x.%j.%N.error
#SBATCH --get-user-env
#SBATCH --clusters=cm2_tiny
#SBATCH --mem=24gb
#SBATCH --cpus-per-task=12
#SBATCH --nodes=1
#SBATCH --mail-type=end
#SBATCH --mail-user=hstubbe@med.lmu.de
#SBATCH --export=NONE
#SBATCH --time=16:00:00


DATAPATH=/dss/dssfs02/lwp-dss-0001/u7x81/u7x81-dss-0000/ru75jul2/seq_data/adv/raw_adv_infection/basecalled/pass
BARCODEPATH=/dss/dssfs02/lwp-dss-0001/u7x81/u7x81-dss-0000/ru75jul2/seq_data/ref_data/

INPUTPATHS="sub1
sub2
sub3
sub4
sub5"

module load charliecloud

for i in $INPUTPATHS
do
    sh ~/ccl_images/pytrim2/app/catfq.sh $DATAPATH/$i/
done

for i in $INPUTPATHS
do
    ( mkdir -p $DATAPATH/$i/demultiplexed/ )
    (ch-run -w ~/ccl_images/pytrim2 -b $DATAPATH:/data/ -b $BARCODEPATH:/barcodes/ -- python /app/pytr2.py $i & )
done

sleep 16h
