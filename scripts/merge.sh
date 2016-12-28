#!/bin/bash

args=("$@")
WKDIR=$1
ARGUP=$2
TARGETDIR="/srv/scanner/"
echo "Working in Folder $WKDIR"
counter=1
for f in $WKDIR/*.pnm
do
echo "Processing $f file..";
FNAME=$(basename "$f")
if [ "$ARGUP" == "true" ]; then
unpaper --no-grayfilter $f "$WKDIR/unpaper$FNAME"
else
  cp $f "$WKDIR/unpaper$FNAME"
fi
# Convert to 8bit
convert -normalize -density 300  "$WKDIR/unpaper$FNAME" "$WKDIR/norm$FNAME"
#/srv/scripts/textcleaner.sh -e none -f 10 -o 5 "$WKDIR/norm$FNAME" "$WKDIR/tc$FNAME"
tesseract -l deu -psm 1 "$WKDIR/tc$FNAME" "$WKDIR/scan$counter" pdf
today=`date +%Y-%m-%d.%H_%M_%S`


if [ $((counter % 2)) == 0 ] && [ $counter != 0 ]; then
    echo "Merging all papers"
    file="$WKDIR/scan$((counter-1)).pdf"
    file1="$WKDIR/scan$counter.pdf"
    file2="$WKDIR/scanr$counter.pdf"
    # rotate
    pdftk $file1 cat 1-endsouth output $file2
    pdftk $file $file2 cat output "$WKDIR/scanready$counter.pdf"

fi
counter=$((counter+1))
done

files=$(ls -v scanready*);
pdftk $files output "$TARGETDIR/scan$today.pdf"
rm -R $WKDIR
