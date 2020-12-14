#!/bin/bash

# This script downloads data files required for the KG update

LOGDIR="$NEO4J_IMPORT"/logs/`date +%Y-%m-%d`
echo "Logging to: " $LOGDIR
mkdir -p "$LOGDIR"

echo "Downloading NCBI Taxonomy Data" >> "$LOGDIR"/update.log 2>&1
mkdir -p "$NEO4J_IMPORT"/ncbi_taxonomy
curl -o "$NEO4J_IMPORT"/ncbi_taxonomy/taxdump.tar.gz ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz >> "$LOGDIR"/update.log 2>&1

tar -xvzf  "$NEO4J_IMPORT"/ncbi_taxonomy/taxdump.tar.gz -C "$NEO4J_IMPORT"/ncbi_taxonomy/ >> "$LOGDIR"/update.log 2>&1