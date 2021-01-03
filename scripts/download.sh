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
# CNCB Strain Data
#
echo "*** Downlading CNCB Strain Data ***"  >> "$LOGDIR"/download.log 2>&1

LDIR="$NEO4J_IMPORT"/cache/raw/cncb

for d in a b c d e f g h i j k l m n
do
 echo "Downloading:" ftp://download.big.ac.cn/GVM/Coronavirus/gff3/$d  >> "$LOGDIR"/download.log 2>&1
 wget --continue --mirror --no-directories ftp://download.big.ac.cn/GVM/Coronavirus/gff3/$d -P $LDIR/$d  >> "$LOGDIR"/download.log 2>&1
done

# old script

#mkdir -p "$LOGDIR"

#echo "Downloading NCBI Taxonomy Data" >> "$LOGDIR"/download.log 2>&1
#mkdir -p "$NEO4J_IMPORT"/ncbi_taxonomy
#curl -o "$NEO4J_IMPORT"/ncbi_taxonomy/taxdump.tar.gz ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz >> "$LOGDIR"/download.log 2>&1

#tar -xvzf  "$NEO4J_IMPORT"/ncbi_taxonomy/taxdump.tar.gz -C "$NEO4J_IMPORT"/ncbi_taxonomy/ >> "$LOGDIR"/download.log 2>&1

