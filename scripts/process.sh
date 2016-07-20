#!/bin/bash

args=("$@")
WKDIR=$1
ARGUP=$2
TARGETDIR="/srv/scanner"
echo "Working in Folder $WKDIR"
counter=1
for f in $WKDIR/*.pnm
do
echo "Processing $f file..";
FNAME=$(basename "$f")
if [ $ARGUP == "true" ]; then
unpaper $f "$WKDIR/unpaper$FNAME"
else
  cp $f "$WKDIR/unpaper$FNAME"
fi

today=`date +%Y-%m-%d.%H_%M_%S`
tesseract -l deu "$WKDIR/unpaper$FNAME" "$WKDIR/scan$counter" pdf
if [ $((counter % 2)) == 0 ] && [ $counter != 0 ]; then
    echo "Merging single paper"
    file="$WKDIR/scan$((counter-1)).pdf"
    file1="$WKDIR/scan$counter.pdf"
   gs -dNOPAUSE -dBATCH -q -sDEVICE=pdfwrite -sOUTPUTFILE="$WKDIR/scan$today.pdf" $file $file1
   mv "$WKDIR/scan$today.pdf" "$TARGETDIR/scan$today.pdf"
fi
counter=$((counter+1))
done
rm -R $WKDIR
