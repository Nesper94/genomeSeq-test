#!/bin/bash

# Script to train a classifier and use it to make a taxonomic classification
# of our 16S sequences. This script is designed to use with an ASVs table.

# Activate Qiime2 conda environment
source activate qiime2-2020.8

# Download the 16S database: Silva_132_release.zip

wget -c https://www.arb-silva.de/fileadmin/silva_databases/qiime/Silva_132_release.zip
unzip Silva_132_release.zip

# Import reference sequences to Qiime2
qiime tools import \
--type 'FeatureData[Sequence]' \
--input-path Silva_132_release/SILVA_132_QIIME_release/rep_set/rep_set_16S_only/99/silva_132_99_16S.fna \
--output-path 99_asvs.qza

# Import taxonomy to Qiime2
qiime tools import \
--type 'FeatureData[Taxonomy]' \
--input-format HeaderlessTSVTaxonomyFormat \
--input-path Silva_132_release/SILVA_132_QIIME_release/taxonomy/taxonomy_all/99/consensus_taxonomy_7_levels.txt \
--output-path ref-taxonomy.qza

# Extract amplified sequence from the reference seqs
qiime feature-classifier extract-reads \
  --i-sequences 99_asvs.qza \
  --p-f-primer GTGCCAGCMGCCGCGGTAA \
  --p-r-primer GGACTACHVGGGTWTCTAAT \
  --p-trunc-len 120 \
  --p-min-length 100 \
  --p-max-length 400 \
  --o-reads ref-seqs.qza

# Train the classifier
qiime feature-classifier fit-classifier-naive-bayes \
  --i-reference-reads ref-seqs.qza \
  --i-reference-taxonomy ref-taxonomy.qza \
  --o-classifier classifier.qza

# Classify
qiime feature-classifier classify-sklearn \
  --i-classifier classifier.qza \
  --i-reads rep-seqs.qza \
  --o-classification taxonomy.qza

# Generate taxonomy visualization
qiime metadata tabulate \
--m-input-file taxonomy.qza \
--o-visualization taxonomy.qzv
