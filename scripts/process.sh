#!/bin/bash

args=("$@")
WKDIR=$1
ARGUP=$2
TARGETDIR=$SCANTARGET
echo "Working in Folder $WKDIR"
counter=1
for f in $WKDIR/*.pnm
do
echo "Processing $f file..";
FNAME=$(basename "$f")
if [ "$ARGUP" == "true" ]; then
unpaper $f "$WKDIR/unpaper$FNAME"
else
  cp $f "$WKDIR/unpaper$FNAME"
fi
# Convert to 8bit
convert -normalize -density 300 -depth 8 "$WKDIR/unpaper$FNAME" "$WKDIR/norm$FNAME"
# extract html OCR with tesseract
#tesseract -l deu -psm 1  "$WKDIR/norm$FNAME" "output$counter.pdf" hocr
# prepare for hocr2pdf
#convert "$WKDIR/norm$FNAME" "$WKDIR/final$FNAME"
# combine html and pdf
#hocr2pdf -i "$WKDIR/final$FNAME" -s -o "$WKDIR/scan$counter.pdf" < "output$counter.pdf.hocr"
tesseract -l deu -psm1 "$WKDIR/norm$FNAME" "$WKDIR/scan$counter" pdf
today=`date +%Y-%m-%d.%H_%M_%S`

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
