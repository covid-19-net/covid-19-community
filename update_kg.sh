#!/bin/bash

# This script updated the covid-19-community knowledge graph

# This script must be run in the covid-19-community conda environment!

# execute all notebooks to create input files for Neo4j database
cd $COVID19/notebooks
 
LOGDIR="$NEO4J_HOME"/import/logs/`date +%Y-%m-%d`
echo Logging to: $LOGDIR

mkdir -p "$LOGDIR"

for f in 0*.ipynb 
do 
  echo "Processing $f file.."
  papermill $f "$LOGDIR"/$f
done

# update the Neo4j database
./run_cyphers.sh