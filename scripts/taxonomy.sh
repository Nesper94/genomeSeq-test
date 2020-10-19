#!/bin/bash

# This script transforms a taxonomy file produced by Qiime2, specifically,
# it deletes the Confidence column and breaks down the taxonomic
# classification separating each taxonomic rank in a separate column.
#
# Juan Camilo Arboleda Rivera
# 2020-10-15

filename=$(date +%F_%H%M%S)-"$1"
cut -f 1,2 "$1" > "$filename" # Get only the two first columns

sed -i 's/;/	/g' "$filename" # Replace semicolon for tab

# Put names to columns of the taxonomy
sed -i 's/Taxon/Domain	Phylum	Class	Order	Family	Genus	Species/' "$filename"

# Remove D_#__ prefix
sed -i 's/D_[0-9]__//g' "$filename"
