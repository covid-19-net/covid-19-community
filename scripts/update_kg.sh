#!/bin/bash

# This script updates the covid-19-community knowledge graph

# download and prepare data files for KG construction
$COVID19/scripts/run_notebooks.sh 

# backup csv files
BACKUPDIR="$NEO4J_IMPORT"/backup/`date +%Y-%m-%d`
mkdir -p "$BACKUPDIR"
cp "$NEO4J_IMPORT"/*.csv "$BACKUPDIR"

# run Cypher scripts to upload the data into the knowledge graph
$COVID19/scripts/run_cyphers.sh "$1"