
# Load packages
library(tidyverse)
library(readxl)
library(sleuth)
library(biomaRt)

baseDirectory = getwd()
sampleOwner = "MS"

# Analysis with sleuth: comparison of mock versus wt_i
comparisonList = list(
                      c("mock", "wt_i", "3M_i"),
                      c("mock", "wt_i"),
                      c("wt_i", "3M_i")
  )


# Read sample data
sampleTab = read_csv(paste(baseDirectory, "sampleTable.csv", sep = "/"))

# Get gene names
mart <- useMart(biomart = "ENSEMBL_MART_ENSEMBL",
                dataset = "hsapiens_gene_ensembl",
                host = "uswest.ensembl.org")
t2g <- getBM(attributes = c("ensembl_transcript_id", 
                            "ensembl_gene_id", 
                            "external_gene_name"),
             mart = mart)
t2g <- rename(t2g, 
              target_id = ensembl_transcript_id,
              ens_gene = ensembl_gene_id,
              ext_gene = external_gene_name)

s2c = subset(sampleTab, is.element(condition,  c("mock", "wt_i", "3M_i")))

so_list = list()
for(comparison_i in comparisonList){
  s2c = subset(sampleTab, is.element(condition, comparison_i))


  # Construct sleuth object (running in 'gene mode')
  so <- sleuth_prep(s2c,
                    target_mapping = t2g,  # if target_mapping AND aggregation_column are provided -> 'gene mode'
                    aggregation_column = 'ens_gene',
                    extra_bootstrap_summary = TRUE,
                    transformation_function = function(x) log2(x + 0.5)
                    ) # load the kallisto processed data into the object
  so <- sleuth_fit(so, ~condition, 'full') # estimate parameters for the sleuth response error measurement (full) model
  so <- sleuth_fit(so, ~1, 'reduced') # estimate parameters for the sleuth reduced model
  so <- sleuth_lrt(so, 'reduced', 'full') # perform differential analysis (testing) using the likelihood ratio test
  so <- sleuth_wt(so, "conditionwt_i", which_model = "full")

  so_list = c(so_list, list(so))

}

names(so_list) = comparisonList

saveRDS(so_list, "so_list.RDS")
