#!/bin/bash

args=("$@")
WKDIR=${args[0]}
TARGETDIR="/srv/scanner"
echo "Working in Folder $WKDIR"

for f in $WKDIR/*.pnm
do
echo "Processing $f file..";
FNAME=$(basename "$f")
echo $FNAME
unpaper $f "$WKDIR/unpaper$FNAME"
today=`date +%Y-%m-%d.%H_%M_%S`
tesseract -l deu "$WKDIR/unpaper$FNAME" "$WKDIR/scan$today" pdf
mv "$WKDIR/scan$today.pdf" "$TARGETDIR/scan$today.pdf"
rm "$WKDIR/unpaper$FNAME"
rm $f
done
rm -R $WKDIR
