#!/bin/bash

# This script must be run in the covid-19-community conda environment!

# execute all notebooks to create input files for Knowledge Graph
cd notebooks

for f in *.ipynb 
do 
  echo "Processing $f file.."
  papermill $f ../logs/$f
done

#
