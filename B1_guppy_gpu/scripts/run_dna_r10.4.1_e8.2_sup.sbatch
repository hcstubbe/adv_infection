#!/bin/bash
#SBATCH -J adi_mock
#SBATCH -p lrz-dgx-a100-80x8
#SBATCH --gres=gpu:1
#SBATCH --mail-type=end
#SBATCH --mail-user=hstubbe@med.lmu.de
#SBATCH -o ./%x.%j.%N.out
#SBATCH -e ./%x.%j.%N.error
#SBATCH --time=72:00:00

DATAPATH=/dss/dssfs02/lwp-dss-0001/u7x81/u7x81-dss-0000/ru75jul2/seq_data/adv/raw_adv_infection ## all files from folder will be included!
GUPPYCFG=dna_r10.4.1_e8.2_260bps_hac_prom.cfg ## e.g. dna_r10.4.1_e8.2_260bps_sup.cfg dna_r10.4.1_e8.2_260bps_hac.cfg, dna_r10.4_e8.1_sup.cfg or dna_r10.3_450bps_sup.cfg
INPUTTYPE=fast5 ## zip, tar.gz or fast5
 
srun --mpi=pmi2 --container-mounts=$DATAPATH:/mnt/data \
     --container-image='hstubbe/guppy_gpu:v6.4.6' \
     bash /app/guppy_gpu_$INPUTTYPE.sh $GUPPYCFG
