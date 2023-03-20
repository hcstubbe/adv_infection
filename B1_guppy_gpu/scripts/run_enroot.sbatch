#!/bin/bash
#SBATCH -J g_mock
#SBATCH -p [GPU NODE]
#SBATCH --gres=gpu:1
#SBATCH --ntasks=1
#SBATCH --mail-type=end
#SBATCH --mail-user=[VALID EMAIL]
#SBATCH -o ./seq_data/logfiles/%x.%j.%N.out
#SBATCH -e ./seq_data/logfiles/%x.%j.%N.error
#SBATCH --time=72:00:00

DATAPATH=/path/to/data/
GUPPYCFG=dna_r10.4_e8.1_sup.cfg ## e.g. dna_r10.4_e8.1_sup.cfg or dna_r10.3_450bps_sup.cfg
INPUTTYPE=fast5 ## zip, tar.gz or fast5
 
srun --mpi=pmi2 --container-mounts=$DATAPATH:/data/ \
     --container-image='hstubbe/guppy_gpu' \
     sh /app/guppy_gpu_$INPUTTYPE.sh $GUPPYCFG
