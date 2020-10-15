#!/bin/bash

# This script transforms a taxonomy file produced by Qiime2, specifically,
# it deletes the Confidence column and breaks down the taxonomic
# classification separating each taxonomic rank in a separate column.
#
# Juan Camilo Arboleda Rivera
# 2020-10-15

filename=$(date +%F_%H%M%S)-"$1"
cut -f 1,2 "$1" > "$filename" # Obtener solo las 2 primeras columnas

sed -i 's/;/	/g' "$filename" # Reemplazar punto y coma por tabulación

# Poner nombres a las columnas de la taxonomía
sed -i 's/Taxon/Domain	Phylum	Class	Order	Family	Genus	Species/' "$filename"

# Eliminar el prefijo D_#__
sed -i 's/D_[0-9]__//g' "$filename"
