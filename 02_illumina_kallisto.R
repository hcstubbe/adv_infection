# Version 26012021


# Load packages
library(tidyverse)
library(readxl)
library(tximport)
library(biomaRt)
library(DESeq2)



# Read sample data
baseDirectory = getwd()
sampleOwner = "Mionchen"
sampleTab = read.csv(paste(baseDirectory, "sampleTable.csv", sep = "/"), stringsAsFactors = T)
rownames(sampleTab) = sampleTab$sample


# Load kallisto data
files = file.path(sampleTab$path, "abundance.h5")
names(files) = sampleTab$sample
txi = tximport(files, type = "kallisto", txOut = TRUE)

# Construce DESeq2 dataset
dds = DESeqDataSetFromTximport(txi,
                               colData = sampleTab,
                               design = ~ condition)

# Pre-filtering
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]



# Specify the reference level
dds$condition <- relevel(dds$condition, ref = "wt_i")


# Differential gene expression
dds = DESeq(dds, parallel = TRUE)
res = results(dds)

# MA-plot
plotMA(res, ylim=c(-2,2))
