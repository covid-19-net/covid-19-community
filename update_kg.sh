#!/bin/bash

# This script updates the covid-19-community knowledge graph

cd $COVID19/notebooks
 
LOGDIR="$NEO4J_HOME"/import/logs/`date +%Y-%m-%d`
#echo Logging to: $LOGDIR

mkdir -p "$LOGDIR"

#date >> $LOGDIR/update.log

# enable conda in bash (see: https://github.com/conda/conda/issues/7980)
eval "$(conda shell.bash hook)"

# create conda environment
conda env remove -n covid-19-community &>> $LOGDIR/update.log
conda env create -f $COVID19/environment.yml &>> $LOGDIR/update.log
conda activate covid-19-community &>> $LOGDIR/update.log

for f in 0*.ipynb 
do 
  echo "Processing $f file.."
  papermill $f "$LOGDIR"/$f
done

# update the Neo4j database
./run_cyphers.sh 