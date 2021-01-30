#!/bin/bash

# This script downloads data files required for the KG update

LOGDIR="$NEO4J_IMPORT"/logs/`date +%Y-%m-%d`
echo "Logging to: " $LOGDIR

echo "*** Downloading EBI SIFTS datafiles ***" >> "$LOGDIR"/download-SIFTS.log 2>&1
LDIR="$NEO4J_IMPORT"/cache/sifts

echo "Downloading:" ftp://ftp.ebi.ac.uk/pub/databases/msd/sifts/xml/  >> "$LOGDIR"/download.log 2>&1
wget --continue --mirror --no-directories ftp://ftp.ebi.ac.uk/pub/databases/msd/sifts/xml/ -P $LDIR/$d  >> "$LOGDIR"/download-SIFTS.log 2>&1
