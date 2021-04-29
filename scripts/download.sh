#!/bin/bash

# This script downloads data files required for the KG update

LOGDIR="$NEO4J_IMPORT"/logs/`date +%Y-%m-%d`
echo "Logging to: " $LOGDIR

#
# NCBI Taxonomy Data
#
echo "*** Downloading NCBI Taxonomy Data ***" >> "$LOGDIR"/download.log 2>&1
LDIR="$NEO4J_IMPORT"/cache/ncbi_taxonomy

echo "Downloading:" ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz >> "$LOGDIR"/download.log 2>&1

wget --continue --mirror --no-directories ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz -P $LDIR  >> "$LOGDIR"/download.log 2>&1
tar -xvzf  "$LDIR"/taxdump.tar.gz -C "$LDIR" >> "$LOGDIR"/download.log 2>&1

#
# CORD-19 Data set
#
echo "*** Downloading CORD-19 data ***" >> "$LOGDIR"/download.log 2>&1
LDIR="$NEO4J_IMPORT"/cache/cord19
wget https://ai2-semanticscholar-cord-19.s3-us-west-2.amazonaws.com/historical_releases/cord-19_2021-04-26.tar.gz -P $LDIR >> "$LOGDIR"/download.log 2>&1
tar -xvzf  "$LDIR"/cord-19_2021-04-26.tar.gz -C "$LDIR" >> "$LOGDIR"/download.log 2>&1
cp "$LDIR"/2021-04-26/metadata.csv "$LDIR"

#
# CNCB Strain Data
#
echo "*** Downloading CNCB Strain Data currently disabled!!! ***"  >> "$LOGDIR"/download.log 2>&1

# The CNCB FTP site is currently undergoing reorganization. It should be available again around end of April 2021.
# See GitHub issue: https://github.com/covid-19-net/covid-19-community/issues/321

LDIR="$NEO4J_IMPORT"/cache/raw/cncb

# for d in a b c d e f g h i j k l m n
# do
#  echo "Downloading:" ftp://download.big.ac.cn/GVM/Coronavirus/gff3/$d  >> "$LOGDIR"/download.log 2>&1
#  wget --continue --mirror --no-directories ftp://download.big.ac.cn/GVM/Coronavirus/gff3/$d -P $LDIR/$d  >> "$LOGDIR"/download.log 2>&1
#done


