## How to use the container

### Run with docker:

```Bash
docker run -v $DATAPATH:/data --rm --gpus all hstubbe/guppy_gpu guppy_basecaller -i [/path/to/input/fast5/] -s [/path/to/output/folder/] [aditional options]
```
#### Using a bash script
Alternatively, you can use the run script as follows:
Modify the parameter in bash_run_dna_r10.4_e8.1_sup.sh and then execute.
This will assume, that all reads are in ONE zip file in the folder specified as datafolder. The script will
* Unzip the fast5 files into a tmp folder in the specified data folder
* Basecall the dast5 files into RUNNAME/basecalled
* Remove the tmp and fast5 folders after run completion

After modifying the script run with:

```Bash
sh ./bash_run_dna_r10.4_e8.1_sup.sh [/path/to/data/]
```

## Using enroot with custom docker images
If you wish to use enrrot on a comute server, modify the appropiate sbatch-script (e.g. run_enroot_zip_dna_r10.4_e8.1_sup.sbatch for the SQK-LSK112-kit (Q20) with super accurate basecalling) in /scripts and run with sbatch as follows:


### Starting enroot container using SLURM with enroot

Submitting SLURM script:
```Bash
sbatch [/path/to/script.sbatch]
```


Inspect SLURM jobs:
```Bash
squeue -u [USER NAME]
```

Cancel SLURM script:
```Bash
scancel [JOB ID]
```


### Other enroot commands
To import a custom image from the [standard docker repository](https://hub.docker.com/):
```Bash
enroot import --output [IMAGE NAME].sqsh docker://[USER NAME]@registry.hub.docker.com#[USERNAME]/[IMAGE NAME]
```

To create enroot container:
```Bash
enroot create [IMAGE NAME].sqsh
```

To start enroot container:
```Bash
enroot start [IMAGE NAME]
```

To remove all enroot containers:

```Bash
enroot remove --force $(enroot list)
```