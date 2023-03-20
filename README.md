# E2A/p53 infection manuscript 

## Code summary
 
This repository contains the analyses scripts for the E2A/p53 infection manuscript:

- A1-A2: llumina data were analyzed using Kallisto and Sleuth. 

- B1-B2: PromethION data were basecalled with Guppy in a Docker/enroot container on the [LRZ AI systems](https://www.lrz.de/) cloud. The samples were demultiplexed using [pytrim2](https://github.com/hcstubbe/pytrim2) on a Docker/Charliecloud container on the [LRZ AI systems](https://www.lrz.de/) cloud. The folders B1 and B2 contain the relevant scripts and Docker files.

- Demultiplexed ONT full-length reads were analyzed for differential gene expression using Oxford Nanopore's [DEG transcriptome pipeline](https://github.com/nanoporetech/pipeline-transcriptome-de).

- 05: Gene expression data from Illumina and PromethION were integrated and analyzed.

## Data availability

The Illumina and PromethION data were submitted to [GEO](https://www.ncbi.nlm.nih.gov/geo/).
