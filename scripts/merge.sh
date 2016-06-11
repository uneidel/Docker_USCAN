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
tesseract -l deu "$WKDIR/unpaper$FNAME" "$WKDIR/scan$FNAME" pdf
done
gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE="scan$today.pdf" -dBATCH `ls -1v $WKDIR/*.pdf`
mv "scan$today.pdf" $TARGETDIR
rm -R $WKDIR
