#!/bin/bash

# This script downloads CNCB Strain Data

LOGDIR="$NEO4J_IMPORT"/logs/`date +%Y-%m-%d`
echo "Logging to: " $LOGDIR

mkdir -p "$LOGDIR"

echo "*** Downloading CNCB Strain Data ***" >> "$LOGDIR"/download.log 2>&1
LDIR="$NEO4J_IMPORT"/cache/cncb_strain

mkdir -p "$LDIR"

echo "Downloading: https://bigd.big.ac.cn/ncov/genome" >> "$LOGDIR"/download.log 2>&1
echo "File download started" $(date) >> "$LOGDIR"/download.log 2>&1

URL="https://bigd.big.ac.cn/ncov/genome/query?&columns%5B0%5D.data=accession&columns%5B0%5D.name=&columns%5B0%5D.searchable=false&columns%5B0%5D.orderable=false&columns%5B0%5D.search.value=&columns%5B0%5D.search.regex=false&columns%5B1%5D.data=name&columns%5B1%5D.name=&columns%5B1%5D.searchable=true&columns%5B1%5D.orderable=true&columns%5B1%5D.search.value=&columns%5B1%5D.search.regex=false&columns%5B2%5D.data=accession&columns%5B2%5D.name=&columns%5B2%5D.searchable=true&columns%5B2%5D.orderable=true&columns%5B2%5D.search.value=&columns%5B2%5D.search.regex=false&columns%5B3%5D.data=gender&columns%5B3%5D.name=&columns%5B3%5D.searchable=true&columns%5B3%5D.orderable=true&columns%5B3%5D.search.value=&columns%5B3%5D.search.regex=false&columns%5B4%5D.data=age&columns%5B4%5D.name=&columns%5B4%5D.searchable=true&columns%5B4%5D.orderable=true&columns%5B4%5D.search.value=&columns%5B4%5D.search.regex=false&columns%5B5%5D.data=source&columns%5B5%5D.name=&columns%5B5%5D.searchable=true&columns%5B5%5D.orderable=true&columns%5B5%5D.search.value=&columns%5B5%5D.search.regex=false&columns%5B6%5D.data=relatedAccession&columns%5B6%5D.name=&columns%5B6%5D.searchable=true&columns%5B6%5D.orderable=true&columns%5B6%5D.search.value=&columns%5B6%5D.search.regex=false&columns%5B7%5D.data=genomeLineage.lineage&columns%5B7%5D.name=&columns%5B7%5D.searchable=true&columns%5B7%5D.orderable=true&columns%5B7%5D.search.value=&columns%5B7%5D.search.regex=false&columns%5B8%5D.data=completeness&columns%5B8%5D.name=&columns%5B8%5D.searchable=true&columns%5B8%5D.orderable=true&columns%5B8%5D.search.value=&columns%5B8%5D.search.regex=false&columns%5B9%5D.data=genomeQuality&columns%5B9%5D.name=&columns%5B9%5D.searchable=false&columns%5B9%5D.orderable=true&columns%5B9%5D.search.value=&columns%5B9%5D.search.regex=false&columns%5B10%5D.data=genomeQuality&columns%5B10%5D.name=&columns%5B10%5D.searchable=false&columns%5B10%5D.orderable=true&columns%5B10%5D.search.value=&columns%5B10%5D.search.regex=false&columns%5B11%5D.data=genomeQuality&columns%5B11%5D.name=&columns%5B11%5D.searchable=false&columns%5B11%5D.orderable=true&columns%5B11%5D.search.value=&columns%5B11%5D.search.regex=false&columns%5B12%5D.data=host&columns%5B12%5D.name=&columns%5B12%5D.searchable=true&columns%5B12%5D.orderable=true&columns%5B12%5D.search.value=&columns%5B12%5D.search.regex=false&columns%5B13%5D.data=collectDate&columns%5B13%5D.name=&columns%5B13%5D.searchable=true&columns%5B13%5D.orderable=true&columns%5B13%5D.search.value=&columns%5B13%5D.search.regex=false&columns%5B14%5D.data=location&columns%5B14%5D.name=&columns%5B14%5D.searchable=true&columns%5B14%5D.orderable=true&columns%5B14%5D.search.value=&columns%5B14%5D.search.regex=false&columns%5B15%5D.data=dataProvider&columns%5B15%5D.name=&columns%5B15%5D.searchable=true&columns%5B15%5D.orderable=true&columns%5B15%5D.search.value=&columns%5B15%5D.search.regex=false&columns%5B16%5D.data=submitDate&columns%5B16%5D.name=&columns%5B16%5D.searchable=true&columns%5B16%5D.orderable=true&columns%5B16%5D.search.value=&columns%5B16%5D.search.regex=false&columns%5B17%5D.data=dataSubmitter&columns%5B17%5D.name=&columns%5B17%5D.searchable=true&columns%5B17%5D.orderable=true&columns%5B17%5D.search.value=&columns%5B17%5D.search.regex=false&columns%5B18%5D.data=createDate&columns%5B18%5D.name=&columns%5B18%5D.searchable=true&columns%5B18%5D.orderable=true&columns%5B18%5D.search.value=&columns%5B18%5D.search.regex=false&columns%5B19%5D.data=country&columns%5B19%5D.name=&columns%5B19%5D.searchable=true&columns%5B19%5D.orderable=true&columns%5B19%5D.search.value=&columns%5B19%5D.search.regex=false&columns%5B20%5D.data=province&columns%5B20%5D.name=&columns%5B20%5D.searchable=true&columns%5B20%5D.orderable=true&columns%5B20%5D.search.value=&columns%5B20%5D.search.regex=false&columns%5B21%5D.data=lastModified&columns%5B21%5D.name=&columns%5B21%5D.searchable=true&columns%5B21%5D.orderable=true&columns%5B21%5D.search.value=&columns%5B21%5D.search.regex=false&order%5B0%5D.column=15&order%5B0%5D.dir=desc&start=0&length=1000000&search.value=&search.regex=false&"

#wget $URL -O "$LDIR"/cncbstrain_tmp.json  >> "$LOGDIR"/download.log 2>&1

if [ -x "$(which wget)" ] ; then
  wget -q $URL -O "$LDIR"/cncbstrain_tmp.json >> "$LOGDIR"/download.log 2>&1
elif [ -x "$(which curl)" ]; then
  curl -o "$LDIR"/cncbstrain_tmp.json -sfL $URL >> "$LOGDIR"/download.log 2>&1
else
  echo "Could not find curl or wget, please install one." >> "$LOGDIR"/download.log 2>&1
fi

FILESIZE=$(wc -c "$LDIR"/cncbstrain_tmp.json | awk '{print $1}')

# check if file size is of expected size
if [ $FILESIZE -gt 500000000 ]
then
  mv "$LDIR"/cncbstrain_tmp.json "$LDIR"/cncbstrain.json
  echo "File download complete" $(date) >> "$LOGDIR"/download.log 2>&1
else
  echo "File download incomplete" $(date) >> "$LOGDIR"/download.log 2>&1
fi


