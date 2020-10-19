#!/bin/bash

# Script to subsample a data file with header, it takes as first argument
# the name of the file to be subsampled and as second argument the number
# of lines to be sampled.
#
# Juan Camilo Arboleda Rivera
# 2020-10-16

filename=subsample-"$1"

# Write header into the new file
head -n 1 "$1" > "$filename"

# Subsample file
tail -n +2 "$1" | shuf -n "$2" >> "$filename"
