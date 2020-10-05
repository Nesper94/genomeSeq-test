#!/bin/bash

# Script to perform a differential abundance analysis using ANCOM in Qiime2

# Activate Qiime2 conda environment
source activate qiime2-2020.8

# From https://docs.qiime2.org/2020.8/tutorials/moving-pictures/#differential-abundance-testing-with-ancom:
# "ANCOM assumes that few (less than about 25%) of the features are changing between 
# groups. If you expect that more features are changing between your groups, you 
# should not use ANCOM as it will be more error-prone (an increase in both Type I 
# and Type II errors is possible)." 
#
# As we expect to find a big difference between microbial composition in cultured vs. uncultured soil, and the 
# ANCOM is best detecting differential abundance between similar samples, it is better to create a data set with 
# only cultured soil and compare Modern and Ancestral samples:
qiime feature-table filter-samples \
    --i-table table.qza \
    --m-metadata-file metadatos.tsv \
    --p-where "[Plant_status]!='Soil'" \
    --o-filtered-table cultured-soil-filtered-table.qza

# Create pseudocount (i.e., replace 0s with 1s to calculate logarithms)
qiime composition add-pseudocount \
  --i-table cultured-soil-filtered-table.qza \
  --o-composition-table composition-table.qza

# Perform ANCOM and save visualization
qiime composition ancom \
    --i-table composition-table.qza \
    --m-metadata-file metadatos.tsv \
    --m-metadata-column Plant_status \
    --o-visualization ancom-plant-status.qzv
